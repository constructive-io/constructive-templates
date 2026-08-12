-- Verify: schemas/catalog_public/tables/resources/grants/authenticated/select/grant


SELECT verify_table_grant('catalog_public.resources', 'SELECT', 'authenticated');