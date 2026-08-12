-- Verify: schemas/myapp_auth_public/tables/principal_entities/indexes/principal_entities_entity_id_idx


SELECT assert_index('myapp_auth_public.principal_entities_entity_id_idx'::regclass, 'myapp_auth_public.principal_entities'::regclass, false);


