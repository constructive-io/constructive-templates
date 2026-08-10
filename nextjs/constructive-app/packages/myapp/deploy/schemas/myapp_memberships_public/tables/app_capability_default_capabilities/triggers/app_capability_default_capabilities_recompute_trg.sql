-- Deploy: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/triggers/app_capability_default_capabilities_recompute_trg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_private/schema
-- requires: schemas/myapp_memberships_public/tables/app_capability_default_capabilities/table
-- requires: schemas/myapp_memberships_private/trigger_fns/app_capability_default_capabilities_recompute_tg


CREATE TRIGGER app_capability_default_capabilities_recompute_trg
BEFORE INSERT OR DELETE OR UPDATE ON myapp_memberships_public.app_capability_default_capabilities
FOR EACH ROW
EXECUTE PROCEDURE myapp_memberships_private.app_capability_default_capabilities_recompute_tg ( );

