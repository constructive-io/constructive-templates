-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/is_read_only/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/table


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD COLUMN is_read_only boolean;

