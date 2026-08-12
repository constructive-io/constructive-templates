-- Deploy: schemas/myapp_auth_public/tables/principal_entities/policies/auth_sel_dir_own/policy
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/table
-- requires: schemas/myapp_auth_public/tables/principal_entities/policies/enable_row_level_security


CREATE POLICY auth_sel_dir_own ON myapp_auth_public.principal_entities
FOR SELECT
TO authenticated
USING (
  owner_id = ((SELECT jwt_public.current_principal_id()))
);

