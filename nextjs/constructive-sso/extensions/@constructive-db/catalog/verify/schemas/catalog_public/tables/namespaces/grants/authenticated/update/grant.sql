-- Verify: schemas/catalog_public/tables/namespaces/grants/authenticated/update/grant


SELECT verify_table_grant('catalog_public.namespaces', 'UPDATE', 'authenticated');