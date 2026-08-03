-- Verify: schemas/catalog_public/tables/apis/grants/authenticated/select/grant


SELECT verify_table_grant('catalog_public.apis', 'SELECT', 'authenticated');