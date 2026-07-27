-- Verify: schemas/myapp_auth_public/tables/principal_entities/indexes/principal_entities_updated_at_idx


SELECT verify_index('myapp_auth_public.principal_entities', 'principal_entities_updated_at_idx');


