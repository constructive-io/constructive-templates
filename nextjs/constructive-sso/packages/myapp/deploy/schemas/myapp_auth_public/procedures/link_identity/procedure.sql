-- Deploy: schemas/myapp_auth_public/procedures/link_identity/procedure
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_private/tables/sessions/table
-- requires: schemas/myapp_auth_private/tables/session_credentials/table
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/table


CREATE FUNCTION myapp_auth_public.link_identity(
  IN service text,
  IN identifier text,
  IN details jsonb DEFAULT NULL
) RETURNS boolean AS $_PGFN_$
DECLARE
  v_user_id uuid;
  v_already_linked boolean;
BEGIN
  v_user_id := jwt_public.current_user_id();
  IF v_user_id IS NULL THEN
    PERFORM errors.raise_error('NOT_AUTHENTICATED', '{}', 'public');
  END IF;
  IF NOT (EXISTS (SELECT 1
  FROM myapp_auth_private.sessions AS s INNER JOIN myapp_auth_private.session_credentials AS c ON c.session_id = s.id
  WHERE
    c.id = jwt_private.current_token_id() AND (((c.mfa_level = 'verified' OR s.last_password_verified > (now() - '30 minutes'::interval)) OR s.last_mfa_verified > (now() - '30 minutes'::interval)) OR s.last_idp_verified > (now() - '30 minutes'::interval)))) THEN
    PERFORM errors.raise_error('STEP_UP_REQUIRED', '{}', 'public');
  END IF;
  IF NOT (EXISTS (SELECT 1
  FROM myapp_auth_private.identity_providers
  WHERE
    slug = link_identity.service AND enabled IS TRUE
  LIMIT
  1)) THEN
    PERFORM errors.raise_error('IDENTITY_PROVIDER_NOT_CONFIGURED', '{}', 'public');
  END IF;
  SELECT
    EXISTS (SELECT 1
    FROM myapp_user_identifiers_private.connected_accounts AS ca
    WHERE
      ca.service = link_identity.service AND ca.identifier = link_identity.identifier) INTO v_already_linked;
  IF v_already_linked IS TRUE THEN
    PERFORM errors.raise_error('IDENTITY_ALREADY_LINKED', '{}', 'public');
  END IF;
  INSERT INTO myapp_user_identifiers_private.connected_accounts (
    owner_id,
    service,
    identifier,
    details,
    is_verified
  )
  VALUES
    (v_user_id, link_identity.service, link_identity.identifier, link_identity.details, COALESCE((link_identity.details->>'email_verified')::boolean, false));
  INSERT INTO myapp_logging_public.audit_log_auth (
    actor_id,
    event,
    success
  )
  VALUES
    (v_user_id, 'link_identity', true);
  RETURN true;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE STRICT SECURITY DEFINER;

