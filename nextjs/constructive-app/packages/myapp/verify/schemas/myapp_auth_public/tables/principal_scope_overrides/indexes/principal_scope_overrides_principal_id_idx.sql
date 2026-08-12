-- Verify: schemas/myapp_auth_public/tables/principal_scope_overrides/indexes/principal_scope_overrides_principal_id_idx


SELECT assert_index('myapp_auth_public.principal_scope_overrides_principal_id_idx'::regclass, 'myapp_auth_public.principal_scope_overrides'::regclass, false);


