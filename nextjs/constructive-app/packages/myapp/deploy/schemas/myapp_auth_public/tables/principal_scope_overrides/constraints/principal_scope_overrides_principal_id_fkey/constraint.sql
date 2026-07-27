-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/constraints/principal_scope_overrides_principal_id_fkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/table


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD CONSTRAINT principal_scope_overrides_principal_id_fkey 
    FOREIGN KEY(principal_id) 
    REFERENCES myapp_auth_public.principals (id) 
    ON DELETE CASCADE;

