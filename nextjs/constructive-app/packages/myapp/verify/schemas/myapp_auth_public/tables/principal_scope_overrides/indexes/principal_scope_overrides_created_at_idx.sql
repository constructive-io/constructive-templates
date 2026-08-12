-- Verify: schemas/myapp_auth_public/tables/principal_scope_overrides/indexes/principal_scope_overrides_created_at_idx


SELECT assert_index('myapp_auth_public.principal_scope_overrides_created_at_idx'::regclass, 'myapp_auth_public.principal_scope_overrides'::regclass, false);


