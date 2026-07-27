-- Deploy schemas/services_private/procedures/domain_verify to pg

-- requires: schemas/services_private/schema
-- requires: schemas/services_public/tables/managed_domains/table
-- requires: schemas/services_public/tables/domain_verifications/table
-- requires: schemas/services_public/tables/domain_events/table
-- requires: schemas/services_private/procedures/domain_issue_challenge

BEGIN;

-- domain:verify — the verify-before-issue guard of the verify->DNS->issue loop.
--
-- Advances the outstanding challenge for a (managed_domain, method) based on
-- what a poller node observed in DNS/HTTP, and mirrors the result onto
-- managed_domains.verification_status. This is a pure state machine: it does NOT
-- itself resolve DNS or fetch HTTP. The observed challenge values (DNS TXT/CNAME
-- record values, or the body served at the HTTP-01 well-known path) are gathered
-- by the poller that fronts this node and passed in as observed_values, so the
-- function stays deterministic, independently invocable, and testable without a
-- resolver. It becomes a graph node LATER; for now a job trigger / the
-- runtime='sql' worker dispatch (registered under the domain:verify task
-- identifier) invokes it with the values its DNS/HTTP fetch produced.
--
-- Transitions (on the active challenge, i.e. the newest row still pending or
-- checking for the (domain, method) pair):
--   * past expires_at                    -> challenge 'expired',  domain 'expired'  (verification_expired)
--   * observed match                     -> challenge 'verified', domain 'verified' (verified)
--   * no match & attempts >= max_attempts-> challenge 'failed',   domain 'failed'   (verification_failed)
--   * no match & attempts <  max_attempts-> challenge 'checking',  domain 'checking' (verification_started on first poll)
-- Every call increments attempts and stamps last_checked_at so job max_attempts
-- / backoff can drive the retry cadence. A match wins even on the final attempt.
CREATE FUNCTION services_private.domain_verify(
    managed_domain_id uuid,
    observed_values text[] DEFAULT NULL,
    method text DEFAULT 'dns_txt_ownership',
    max_attempts integer DEFAULT 10,
    actor_id uuid DEFAULT NULL
) RETURNS services_public.domain_verifications AS $$
DECLARE
    challenge services_public.domain_verifications;
    domain_name text;
    was_pending boolean;
    matched boolean;
    new_attempts integer;
BEGIN
    IF domain_verify.method NOT IN ('dns_txt_ownership', 'http_01', 'dns_01_acme') THEN
        RAISE EXCEPTION 'DOMAIN_VERIFY_BAD_METHOD: unsupported verification method %', domain_verify.method
            USING ERRCODE = 'check_violation';
    END IF;

    -- The active challenge is the newest still-open row for this (domain, method).
    -- issue_challenge guarantees at most one is pending/checking at a time.
    SELECT dv.* INTO challenge
      FROM services_public.domain_verifications AS dv
     WHERE dv.managed_domain_id = domain_verify.managed_domain_id
       AND dv.method = domain_verify.method
       AND dv.status IN ('pending', 'checking')
     ORDER BY dv.created_at DESC
     LIMIT 1;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'DOMAIN_VERIFY_NO_CHALLENGE: no outstanding % challenge for managed_domain %', domain_verify.method, domain_verify.managed_domain_id
            USING ERRCODE = 'no_data_found';
    END IF;

    SELECT md.domain INTO domain_name
      FROM services_public.managed_domains AS md
     WHERE md.id = domain_verify.managed_domain_id;

    was_pending := (challenge.status = 'pending');
    new_attempts := challenge.attempts + 1;

    -- Expiry wins over everything: a lapsed challenge must be reissued.
    IF challenge.expires_at IS NOT NULL AND now() > challenge.expires_at THEN
        UPDATE services_public.domain_verifications
           SET status = 'expired',
               attempts = new_attempts,
               last_checked_at = now(),
               error = 'challenge expired before verification',
               updated_at = now()
         WHERE id = challenge.id
        RETURNING * INTO challenge;

        UPDATE services_public.managed_domains
           SET verification_status = 'expired'
         WHERE id = domain_verify.managed_domain_id;

        INSERT INTO services_public.domain_events
            (owner_id, managed_domain_id, domain_verification_id, event_type, actor_id, message, metadata)
        VALUES
            (challenge.owner_id, domain_verify.managed_domain_id, challenge.id, 'verification_expired', domain_verify.actor_id,
             'Verification challenge for ' || coalesce(domain_name, '?') || ' expired after ' || new_attempts || ' attempt(s)',
             jsonb_build_object('method', domain_verify.method, 'attempts', new_attempts));

        RETURN challenge;
    END IF;

    matched := domain_verify.observed_values IS NOT NULL
               AND challenge.record_value = ANY(domain_verify.observed_values);

    IF matched THEN
        UPDATE services_public.domain_verifications
           SET status = 'verified',
               attempts = new_attempts,
               last_checked_at = now(),
               verified_at = now(),
               error = NULL,
               updated_at = now()
         WHERE id = challenge.id
        RETURNING * INTO challenge;

        UPDATE services_public.managed_domains
           SET verification_status = 'verified',
               verified_at = now()
         WHERE id = domain_verify.managed_domain_id;

        INSERT INTO services_public.domain_events
            (owner_id, managed_domain_id, domain_verification_id, event_type, actor_id, message, metadata)
        VALUES
            (challenge.owner_id, domain_verify.managed_domain_id, challenge.id, 'verified', domain_verify.actor_id,
             'Verified ' || domain_verify.method || ' challenge for ' || coalesce(domain_name, '?'),
             jsonb_build_object('method', domain_verify.method, 'attempts', new_attempts));

        RETURN challenge;
    END IF;

    IF new_attempts >= domain_verify.max_attempts THEN
        UPDATE services_public.domain_verifications
           SET status = 'failed',
               attempts = new_attempts,
               last_checked_at = now(),
               error = 'challenge not observed after ' || new_attempts || ' attempt(s)',
               updated_at = now()
         WHERE id = challenge.id
        RETURNING * INTO challenge;

        UPDATE services_public.managed_domains
           SET verification_status = 'failed'
         WHERE id = domain_verify.managed_domain_id;

        INSERT INTO services_public.domain_events
            (owner_id, managed_domain_id, domain_verification_id, event_type, actor_id, message, metadata)
        VALUES
            (challenge.owner_id, domain_verify.managed_domain_id, challenge.id, 'verification_failed', domain_verify.actor_id,
             'Verification for ' || coalesce(domain_name, '?') || ' failed after ' || new_attempts || ' attempt(s)',
             jsonb_build_object('method', domain_verify.method, 'attempts', new_attempts, 'max_attempts', domain_verify.max_attempts));

        RETURN challenge;
    END IF;

    -- Still outstanding: record the poll and keep waiting.
    UPDATE services_public.domain_verifications
       SET status = 'checking',
           attempts = new_attempts,
           last_checked_at = now(),
           error = 'challenge not yet observed',
           updated_at = now()
     WHERE id = challenge.id
    RETURNING * INTO challenge;

    UPDATE services_public.managed_domains
       SET verification_status = 'checking'
     WHERE id = domain_verify.managed_domain_id;

    -- Emit the started event once, on the pending -> checking transition, so the
    -- audit trail records the poll cycle beginning without one row per attempt.
    IF was_pending THEN
        INSERT INTO services_public.domain_events
            (owner_id, managed_domain_id, domain_verification_id, event_type, actor_id, message, metadata)
        VALUES
            (challenge.owner_id, domain_verify.managed_domain_id, challenge.id, 'verification_started', domain_verify.actor_id,
             'Started polling ' || domain_verify.method || ' challenge for ' || coalesce(domain_name, '?'),
             jsonb_build_object('method', domain_verify.method, 'attempts', new_attempts));
    END IF;

    RETURN challenge;
END;
$$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

COMMENT ON FUNCTION services_private.domain_verify(uuid, text[], text, integer, uuid) IS 'domain:verify — verify-before-issue guard: advances the outstanding challenge from the DNS/HTTP values a poller observed (observed_values), mirrors verification_status onto managed_domains, and emits verification_started/verified/verification_failed/verification_expired events.';

GRANT EXECUTE ON FUNCTION services_private.domain_verify(uuid, text[], text, integer, uuid) TO authenticated;
GRANT EXECUTE ON FUNCTION services_private.domain_verify(uuid, text[], text, integer, uuid) TO administrator;

COMMIT;
