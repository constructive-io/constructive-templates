-- Deploy: schemas/myapp_user_identifiers_public/tables/phone_numbers/policies/auth_upd_dir_own/policy
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/table
-- requires: schemas/myapp_user_identifiers_public/tables/phone_numbers/policies/enable_row_level_security


CREATE POLICY auth_upd_dir_own ON myapp_user_identifiers_public.phone_numbers
FOR UPDATE
TO authenticated
USING (
  owner_id = jwt_public.current_principal_id()
);

