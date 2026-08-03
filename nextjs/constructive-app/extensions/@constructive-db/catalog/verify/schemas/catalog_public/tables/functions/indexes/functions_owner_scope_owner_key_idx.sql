-- Verify: schemas/catalog_public/tables/functions/indexes/functions_owner_scope_owner_key_idx


SELECT verify_index('catalog_public.functions', 'functions_owner_scope_owner_key_idx');