-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/is_read_only/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/table
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/is_read_only/column


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN is_read_only SET NOT NULL;

