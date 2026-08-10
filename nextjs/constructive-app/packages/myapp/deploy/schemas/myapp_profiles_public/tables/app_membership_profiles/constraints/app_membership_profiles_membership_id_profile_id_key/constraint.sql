-- Deploy: schemas/myapp_profiles_public/tables/app_membership_profiles/constraints/app_membership_profiles_membership_id_profile_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/app_membership_profiles/table


ALTER TABLE myapp_profiles_public.app_membership_profiles 
  ADD CONSTRAINT app_membership_profiles_membership_id_profile_id_key 
    UNIQUE (membership_id, profile_id);

