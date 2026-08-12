-- Deploy: schemas/myapp_profiles_public/tables/org_membership_profiles/columns/actor_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/org_membership_profiles/table
-- requires: schemas/myapp_profiles_public/tables/org_membership_profiles/columns/actor_id/column


ALTER TABLE myapp_profiles_public.org_membership_profiles 
  ALTER COLUMN actor_id SET NOT NULL;

