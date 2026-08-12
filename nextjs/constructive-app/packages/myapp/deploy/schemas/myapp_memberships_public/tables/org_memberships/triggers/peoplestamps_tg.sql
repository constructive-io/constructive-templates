-- Deploy: schemas/myapp_memberships_public/tables/org_memberships/triggers/peoplestamps_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/org_memberships/table
-- requires: schemas/myapp_memberships_public/trigger_fns/org_memberships_peoplestamps


CREATE TRIGGER peoplestamps_tg
BEFORE INSERT OR UPDATE ON myapp_memberships_public.org_memberships
FOR EACH ROW
EXECUTE PROCEDURE myapp_memberships_public.org_memberships_peoplestamps ( );

