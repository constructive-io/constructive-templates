-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/membership_type/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/table
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/columns/membership_type/column


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ALTER COLUMN membership_type SET NOT NULL;

