-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/table
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/id/column


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN id SET DEFAULT uuidv7();

