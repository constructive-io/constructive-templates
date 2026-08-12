-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/membership_type/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/table


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD COLUMN membership_type int4;

