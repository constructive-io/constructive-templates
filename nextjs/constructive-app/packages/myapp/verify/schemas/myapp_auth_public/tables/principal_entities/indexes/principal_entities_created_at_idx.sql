-- Verify: schemas/myapp_auth_public/tables/principal_entities/indexes/principal_entities_created_at_idx


SELECT assert_index('myapp_auth_public.principal_entities_created_at_idx'::regclass, 'myapp_auth_public.principal_entities'::regclass, false);


