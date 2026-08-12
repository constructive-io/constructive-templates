-- Deploy: schemas/myapp_profiles_public/tables/app_membership_profiles/triggers/app_membership_profiles_remove_trg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_private/schema
-- requires: schemas/myapp_profiles_public/tables/app_membership_profiles/table
-- requires: schemas/myapp_profiles_private/trigger_fns/app_membership_profiles_remove_tg


CREATE TRIGGER app_membership_profiles_remove_trg
AFTER DELETE ON myapp_profiles_public.app_membership_profiles
FOR EACH ROW
EXECUTE PROCEDURE myapp_profiles_private.app_membership_profiles_remove_tg ( );

