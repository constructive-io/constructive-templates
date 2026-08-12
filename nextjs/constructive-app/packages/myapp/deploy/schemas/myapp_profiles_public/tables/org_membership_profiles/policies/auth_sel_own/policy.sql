-- Deploy: schemas/myapp_profiles_public/tables/org_membership_profiles/policies/auth_sel_own/policy
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/org_membership_profiles/table
-- requires: schemas/myapp_profiles_public/tables/org_membership_profiles/policies/enable_row_level_security


CREATE POLICY auth_sel_own ON myapp_profiles_public.org_membership_profiles
FOR SELECT
TO authenticated
USING (
  actor_id = ((SELECT jwt_public.current_principal_id()))
);

