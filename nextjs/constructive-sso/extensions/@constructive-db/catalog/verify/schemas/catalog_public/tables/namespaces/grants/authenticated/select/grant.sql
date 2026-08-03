-- Verify: schemas/catalog_public/tables/namespaces/grants/authenticated/select/grant


SELECT verify_table_grant('catalog_public.namespaces', 'SELECT', 'authenticated');