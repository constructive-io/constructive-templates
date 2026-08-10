-- Deploy: schemas/myapp_profiles_public/tables/app_membership_profiles/policies/auth_sel_app_mem/policy
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/app_membership_profiles/table
-- requires: schemas/myapp_profiles_public/tables/app_membership_profiles/policies/enable_row_level_security


CREATE POLICY auth_sel_app_mem ON myapp_profiles_public.app_membership_profiles
FOR SELECT
TO authenticated
USING (
  EXISTS (SELECT 1
  FROM myapp_memberships_private.app_memberships_sprt AS app_sprt
  WHERE
      app_sprt.actor_id = ((SELECT jwt_public.current_principal_id())) AND (app_sprt.capabilities & '0000000000000000000000000000000000000000000000000000000000000001') = '0000000000000000000000000000000000000000000000000000000000000001')
);

