-- Deploy: schemas/myapp_memberships_public/tables/app_memberships/triggers/_00020_app_memberships_profiles_seed_utrg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_private/schema
-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_memberships/table
-- requires: schemas/myapp_profiles_private/trigger_fns/app_memberships_profiles_seed_tg


CREATE TRIGGER _00020_app_memberships_profiles_seed_utrg
AFTER UPDATE ON myapp_memberships_public.app_memberships
FOR EACH ROW
WHEN (OLD.profile_id IS DISTINCT FROM NEW.profile_id)
EXECUTE PROCEDURE myapp_profiles_private.app_memberships_profiles_seed_tg ( );

