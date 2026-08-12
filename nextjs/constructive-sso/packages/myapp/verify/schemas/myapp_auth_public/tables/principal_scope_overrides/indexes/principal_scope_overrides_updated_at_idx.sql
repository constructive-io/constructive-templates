-- Verify: schemas/myapp_auth_public/tables/principal_scope_overrides/indexes/principal_scope_overrides_updated_at_idx


SELECT verify_index('myapp_auth_public.principal_scope_overrides', 'principal_scope_overrides_updated_at_idx');


