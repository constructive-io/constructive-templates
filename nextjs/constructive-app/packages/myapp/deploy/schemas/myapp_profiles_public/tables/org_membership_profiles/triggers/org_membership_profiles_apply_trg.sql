-- Deploy: schemas/myapp_profiles_public/tables/org_membership_profiles/triggers/org_membership_profiles_apply_trg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_private/schema
-- requires: schemas/myapp_profiles_public/tables/org_membership_profiles/table
-- requires: schemas/myapp_profiles_private/trigger_fns/org_membership_profiles_apply_tg


CREATE TRIGGER org_membership_profiles_apply_trg
AFTER INSERT ON myapp_profiles_public.org_membership_profiles
FOR EACH ROW
EXECUTE PROCEDURE myapp_profiles_private.org_membership_profiles_apply_tg ( );

