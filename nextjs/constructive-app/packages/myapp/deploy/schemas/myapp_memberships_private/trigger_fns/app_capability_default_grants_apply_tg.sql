-- Deploy: schemas/myapp_memberships_private/trigger_fns/app_capability_default_grants_apply_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_private/schema
-- requires: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/table


CREATE FUNCTION myapp_memberships_private.app_capability_default_grants_apply_tg() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  IF NEW.is_grant IS TRUE THEN
    INSERT INTO myapp_memberships_public.app_capability_default_capabilities (
      capability_id
    )
    VALUES
      (NEW.capability_id)
    ON CONFLICT (capability_id) DO NOTHING;
  ELSE
    DELETE FROM myapp_memberships_public.app_capability_default_capabilities
    WHERE
      capability_id = NEW.capability_id;
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE;

