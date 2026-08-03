-- Verify: schemas/catalog_public/tables/namespaces/grants/authenticated/insert/grant


SELECT verify_table_grant('catalog_public.namespaces', 'INSERT', 'authenticated');