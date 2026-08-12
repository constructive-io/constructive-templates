-- Deploy: schemas/myapp_memberships_private/trigger_fns/org_capability_default_grants_apply_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_private/schema
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/table


CREATE FUNCTION myapp_memberships_private.org_capability_default_grants_apply_tg() RETURNS TRIGGER AS $_PGFN_$
BEGIN
  IF NEW.is_grant IS TRUE THEN
    INSERT INTO myapp_memberships_public.org_capability_default_capabilities (
      capability_id,
      entity_id
    )
    VALUES
      (NEW.capability_id, NEW.entity_id)
    ON CONFLICT (capability_id, entity_id) DO NOTHING;
  ELSE
    DELETE FROM myapp_memberships_public.org_capability_default_capabilities
    WHERE
      capability_id = NEW.capability_id AND entity_id = NEW.entity_id;
  END IF;
  RETURN NEW;
END;
$_PGFN_$ LANGUAGE plpgsql VOLATILE;

