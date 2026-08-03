-- Verify: schemas/catalog_public/tables/functions/indexes/functions_updated_at_idx


SELECT verify_index('catalog_public.functions', 'functions_updated_at_idx');