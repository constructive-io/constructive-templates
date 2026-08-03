-- Verify: schemas/catalog_public/tables/namespaces/grants/authenticated/delete/grant


SELECT verify_table_grant('catalog_public.namespaces', 'DELETE', 'authenticated');