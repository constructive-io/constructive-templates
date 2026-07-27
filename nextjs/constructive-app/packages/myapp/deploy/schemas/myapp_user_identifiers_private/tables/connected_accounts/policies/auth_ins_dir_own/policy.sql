-- Deploy: schemas/myapp_user_identifiers_private/tables/connected_accounts/policies/auth_ins_dir_own/policy
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_private/schema
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/table
-- requires: schemas/myapp_user_identifiers_private/tables/connected_accounts/policies/enable_row_level_security


CREATE POLICY auth_ins_dir_own ON myapp_user_identifiers_private.connected_accounts
FOR INSERT
TO authenticated
WITH CHECK (
  owner_id = jwt_public.current_principal_id()
);

