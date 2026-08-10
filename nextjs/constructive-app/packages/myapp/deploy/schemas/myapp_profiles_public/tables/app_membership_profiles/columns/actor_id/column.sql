-- Deploy: schemas/myapp_profiles_public/tables/app_membership_profiles/columns/actor_id/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/app_membership_profiles/table


ALTER TABLE myapp_profiles_public.app_membership_profiles 
  ADD COLUMN actor_id uuid;

