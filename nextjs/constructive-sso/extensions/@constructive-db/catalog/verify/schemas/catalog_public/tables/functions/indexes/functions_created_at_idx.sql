-- Verify: schemas/catalog_public/tables/functions/indexes/functions_created_at_idx


SELECT verify_index('catalog_public.functions', 'functions_created_at_idx');