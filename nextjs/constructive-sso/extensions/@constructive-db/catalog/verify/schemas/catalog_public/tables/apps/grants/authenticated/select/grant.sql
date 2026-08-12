-- Verify: schemas/catalog_public/tables/apps/grants/authenticated/select/grant


SELECT verify_table_grant('catalog_public.apps', 'SELECT', 'authenticated');