-- Verify: schemas/catalog_public/tables/functions/indexes/functions_database_id_idx


SELECT verify_index('catalog_public.functions', 'functions_database_id_idx');