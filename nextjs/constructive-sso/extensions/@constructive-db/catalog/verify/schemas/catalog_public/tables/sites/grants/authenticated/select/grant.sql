-- Verify: schemas/catalog_public/tables/sites/grants/authenticated/select/grant


SELECT verify_table_grant('catalog_public.sites', 'SELECT', 'authenticated');