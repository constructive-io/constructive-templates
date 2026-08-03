-- Verify: schemas/catalog_public/tables/domains/grants/authenticated/select/grant


SELECT verify_table_grant('catalog_public.domains', 'SELECT', 'authenticated');