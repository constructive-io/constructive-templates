-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/constraints/principal_scope_overrides_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/table


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD CONSTRAINT principal_scope_overrides_pkey PRIMARY KEY (id);

