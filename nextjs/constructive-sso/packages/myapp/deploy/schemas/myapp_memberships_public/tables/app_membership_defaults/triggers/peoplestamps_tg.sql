-- Deploy: schemas/myapp_memberships_public/tables/app_membership_defaults/triggers/peoplestamps_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_membership_defaults/table
-- requires: schemas/myapp_memberships_public/trigger_fns/app_membership_defaults_peoplestamps


CREATE TRIGGER peoplestamps_tg
BEFORE INSERT OR UPDATE ON myapp_memberships_public.app_membership_defaults
FOR EACH ROW
EXECUTE PROCEDURE myapp_memberships_public.app_membership_defaults_peoplestamps ( );

