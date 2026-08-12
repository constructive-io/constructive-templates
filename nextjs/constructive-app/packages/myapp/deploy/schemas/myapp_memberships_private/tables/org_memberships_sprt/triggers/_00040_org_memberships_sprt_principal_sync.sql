-- Deploy: schemas/myapp_memberships_private/tables/org_memberships_sprt/triggers/_00040_org_memberships_sprt_principal_sync
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_private/schema
-- requires: schemas/myapp_memberships_private/schema
-- requires: schemas/myapp_memberships_private/tables/org_memberships_sprt/table
-- requires: schemas/myapp_auth_private/trigger_fns/org_memberships_sprt_principal_sync_tg


CREATE TRIGGER _00040_org_memberships_sprt_principal_sync
AFTER INSERT OR DELETE OR UPDATE ON myapp_memberships_private.org_memberships_sprt
FOR EACH ROW
EXECUTE PROCEDURE myapp_auth_private.org_memberships_sprt_principal_sync_tg ( );

