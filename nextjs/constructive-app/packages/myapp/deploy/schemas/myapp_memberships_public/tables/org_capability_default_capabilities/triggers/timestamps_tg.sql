-- Deploy: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/triggers/timestamps_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/org_capability_default_capabilities/table


CREATE TRIGGER timestamps_tg
BEFORE INSERT OR UPDATE ON myapp_memberships_public.org_capability_default_capabilities
FOR EACH ROW
EXECUTE PROCEDURE stamps.timestamps ( );

