-- Verify: schemas/catalog_public/tables/functions/indexes/functions_is_visible_idx


SELECT verify_index('catalog_public.functions', 'functions_is_visible_idx');