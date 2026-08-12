-- Deploy: schemas/myapp_memberships_public/tables/org_memberships/triggers/_00020_org_memberships_profiles_seed_itrg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_private/schema
-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/org_memberships/table
-- requires: schemas/myapp_profiles_private/trigger_fns/org_memberships_profiles_seed_tg


CREATE TRIGGER _00020_org_memberships_profiles_seed_itrg
AFTER INSERT ON myapp_memberships_public.org_memberships
FOR EACH ROW
EXECUTE PROCEDURE myapp_profiles_private.org_memberships_profiles_seed_tg ( );

