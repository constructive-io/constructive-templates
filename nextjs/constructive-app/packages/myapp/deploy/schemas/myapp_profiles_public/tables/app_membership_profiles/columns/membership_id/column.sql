-- Deploy: schemas/myapp_profiles_public/tables/app_membership_profiles/columns/membership_id/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/app_membership_profiles/table


ALTER TABLE myapp_profiles_public.app_membership_profiles 
  ADD COLUMN membership_id uuid;

