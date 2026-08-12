-- Deploy: schemas/myapp_memberships_public/tables/org_membership_settings/triggers/peoplestamps_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/org_membership_settings/table
-- requires: schemas/myapp_memberships_public/trigger_fns/org_membership_settings_peoplestamps


CREATE TRIGGER peoplestamps_tg
BEFORE INSERT OR UPDATE ON myapp_memberships_public.org_membership_settings
FOR EACH ROW
EXECUTE PROCEDURE myapp_memberships_public.org_membership_settings_peoplestamps ( );

