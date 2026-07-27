-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/principal_id/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/table


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD COLUMN principal_id uuid;

