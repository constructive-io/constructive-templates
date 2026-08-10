-- Deploy: schemas/myapp_profiles_public/tables/app_membership_profiles/constraints/app_membership_profiles_profile_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/app_profiles/table
-- requires: schemas/myapp_profiles_public/tables/app_membership_profiles/table


ALTER TABLE myapp_profiles_public.app_membership_profiles 
  ADD CONSTRAINT app_membership_profiles_profile_id_fkey 
    FOREIGN KEY(profile_id) 
    REFERENCES myapp_profiles_public.app_profiles (id) 
    ON DELETE CASCADE;

