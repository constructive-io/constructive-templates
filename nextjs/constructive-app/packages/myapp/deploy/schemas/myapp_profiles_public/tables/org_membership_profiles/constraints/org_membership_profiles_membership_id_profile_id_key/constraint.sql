-- Deploy: schemas/myapp_profiles_public/tables/org_membership_profiles/constraints/org_membership_profiles_membership_id_profile_id_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/org_membership_profiles/table


ALTER TABLE myapp_profiles_public.org_membership_profiles 
  ADD CONSTRAINT org_membership_profiles_membership_id_profile_id_key 
    UNIQUE (membership_id, profile_id);

