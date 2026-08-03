-- Verify: schemas/catalog_public/tables/functions/grants/authenticated/delete/grant


SELECT verify_table_grant('catalog_public.functions', 'DELETE', 'authenticated');