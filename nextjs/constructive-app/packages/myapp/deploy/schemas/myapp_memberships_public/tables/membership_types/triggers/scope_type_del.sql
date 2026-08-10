-- Deploy: schemas/myapp_memberships_public/tables/membership_types/triggers/scope_type_del
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/membership_types/table
-- requires: schemas/myapp_memberships_public/trigger_fns/tg_membership_types_scope_type_del


CREATE TRIGGER scope_type_del
AFTER DELETE ON myapp_memberships_public.membership_types
FOR EACH ROW
EXECUTE PROCEDURE myapp_memberships_public.tg_membership_types_scope_type_del ( );

