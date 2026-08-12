-- Deploy: schemas/myapp_profiles_public/tables/org_profile_capabilities/triggers/timestamps_tg
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/org_profile_capabilities/table


CREATE TRIGGER timestamps_tg
BEFORE INSERT OR UPDATE ON myapp_profiles_public.org_profile_capabilities
FOR EACH ROW
EXECUTE PROCEDURE stamps.timestamps ( );

