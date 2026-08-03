-- Verify: schemas/catalog_public/tables/resource_definitions/indexes/resource_definitions_owner_scope_owner_key_idx


SELECT verify_index('catalog_public.resource_definitions', 'resource_definitions_owner_scope_owner_key_idx');