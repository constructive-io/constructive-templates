-- Deploy: schemas/myapp_profiles_private/trigger_fns/app_profile_capabilities_recompute_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_private/schema
-- requires: schemas/myapp_profiles_public/tables/app_profiles/table
-- requires: schemas/myapp_capabilities_public/tables/app_capabilities/table
-- requires: schemas/myapp_profiles_public/tables/app_profile_capabilities/table


CREATE FUNCTION myapp_profiles_private.app_profile_capabilities_recompute_tg() RETURNS TRIGGER AS $_PGFN_$
DECLARE
  v_profile_id uuid;
  v_capabilities bit(64);
BEGIN
  IF TG_OP = 'DELETE' THEN
    SELECT OLD.profile_id INTO v_profile_id;
  ELSE
    SELECT NEW.profile_id INTO v_profile_id;
  END IF;
  SELECT coalesce(bit_or(p.bitstr), (lpad('', 64, '0'))::bit(64)::bit(64))
  FROM myapp_profiles_public.app_profile_capabilities AS pp INNER JOIN myapp_capabilities_public.app_capabilities AS p ON p.id = pp.capability_id
  WHERE
    pp.profile_id = v_profile_id INTO v_capabilities;
  UPDATE myapp_profiles_public.app_profiles SET
  capabilities = v_capabilities
  WHERE
    id = v_profile_id;
  IF TG_OP = 'DELETE' THEN
    RETURN OLD;
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

