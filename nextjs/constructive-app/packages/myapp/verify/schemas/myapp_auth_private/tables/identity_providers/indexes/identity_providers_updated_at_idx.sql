-- Verify: schemas/myapp_auth_private/tables/identity_providers/indexes/identity_providers_updated_at_idx


SELECT assert_index('myapp_auth_private.identity_providers_updated_at_idx'::regclass, 'myapp_auth_private.identity_providers'::regclass, false);


