-- Deploy: schemas/myapp_profiles_public/tables/app_membership_profiles/constraints/app_membership_profiles_membership_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_memberships_public/schema
-- requires: schemas/myapp_memberships_public/tables/app_memberships/table
-- requires: schemas/myapp_profiles_public/tables/app_membership_profiles/table


ALTER TABLE myapp_profiles_public.app_membership_profiles 
  ADD CONSTRAINT app_membership_profiles_membership_id_fkey 
    FOREIGN KEY(membership_id) 
    REFERENCES myapp_memberships_public.app_memberships (id) 
    ON DELETE CASCADE;

