-- Verify: schemas/catalog_public/tables/resource_installations/grants/authenticated/select/grant


SELECT verify_table_grant('catalog_public.resource_installations', 'SELECT', 'authenticated');