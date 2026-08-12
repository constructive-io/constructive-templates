-- Deploy: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/policies/auth_upd_dir_own/policy
-- made with <3 @ constructive.io

-- requires: schemas/myapp_user_identifiers_public/schema
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/table
-- requires: schemas/myapp_user_identifiers_public/tables/webauthn_credentials/policies/enable_row_level_security


CREATE POLICY auth_upd_dir_own ON myapp_user_identifiers_public.webauthn_credentials
FOR UPDATE
TO authenticated
USING (
  owner_id = ((SELECT jwt_public.current_principal_id()))
);

