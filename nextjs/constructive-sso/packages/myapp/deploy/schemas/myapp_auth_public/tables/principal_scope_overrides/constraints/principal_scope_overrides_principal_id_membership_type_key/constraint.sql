-- Deploy: schemas/myapp_auth_public/tables/principal_scope_overrides/constraints/principal_scope_overrides_principal_id_membership_type_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_scope_overrides/table


ALTER TABLE myapp_auth_public.principal_scope_overrides 
  ADD CONSTRAINT principal_scope_overrides_principal_id_membership_type_key 
    UNIQUE (principal_id, membership_type);

