-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/policies/auth_sel_dir_own/policy
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/policies/enable_row_level_security


CREATE POLICY auth_sel_dir_own ON myapp_user_identifiers_public.phone_numbers
FOR SELECT
TO authenticated
USING (
  owner_id = ((SELECT jwt_public.current_principal_id()))
);

