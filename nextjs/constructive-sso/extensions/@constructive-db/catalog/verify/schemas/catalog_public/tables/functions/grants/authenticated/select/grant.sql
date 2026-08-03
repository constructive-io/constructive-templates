-- Verify: schemas/catalog_public/tables/functions/grants/authenticated/select/grant


SELECT verify_table_grant('catalog_public.functions', 'SELECT', 'authenticated');