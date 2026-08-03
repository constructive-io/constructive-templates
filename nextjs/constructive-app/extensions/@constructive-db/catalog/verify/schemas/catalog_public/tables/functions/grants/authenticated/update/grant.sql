-- Verify: schemas/catalog_public/tables/functions/grants/authenticated/update/grant


SELECT verify_table_grant('catalog_public.functions', 'UPDATE', 'authenticated');