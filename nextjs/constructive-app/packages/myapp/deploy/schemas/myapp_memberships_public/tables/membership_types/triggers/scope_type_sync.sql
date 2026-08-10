-- Deploy: schemas/myapp_memberships_public/tables/membership_types/triggers/scope_type_sync
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/membership_types/table
-- requires: schemas/myapp_memberships_public/trigger_fns/tg_membership_types_scope_type_sync


CREATE TRIGGER scope_type_sync
AFTER INSERT OR UPDATE ON myapp_memberships_public.membership_types
FOR EACH ROW
EXECUTE PROCEDURE myapp_memberships_public.tg_membership_types_scope_type_sync ( );

