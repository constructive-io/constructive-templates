-- Deploy: schemas/myapp_profiles_private/trigger_fns/app_profile_definition_grants_apply_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_private/schema
-- requires: schemas/myapp_profiles_public/tables/app_profile_capabilities/table


CREATE FUNCTION myapp_profiles_private.app_profile_definition_grants_apply_tg() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  IF NEW.is_grant IS TRUE THEN
    INSERT INTO myapp_profiles_public.app_profile_capabilities (
      profile_id,
      capability_id
    )
    VALUES
      (NEW.profile_id, NEW.capability_id)
    ON CONFLICT (profile_id, capability_id) DO NOTHING;
  ELSE
    DELETE FROM myapp_profiles_public.app_profile_capabilities
    WHERE
      profile_id = NEW.profile_id AND capability_id = NEW.capability_id;
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE SECURITY DEFINER;

