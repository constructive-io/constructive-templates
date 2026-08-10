-- Deploy: schemas/myapp_profiles_public/tables/app_membership_profiles/columns/membership_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/app_membership_profiles/table
-- requires: schemas/myapp_profiles_public/tables/app_membership_profiles/columns/membership_id/column


ALTER TABLE myapp_profiles_public.app_membership_profiles 
  ALTER COLUMN membership_id SET NOT NULL;

