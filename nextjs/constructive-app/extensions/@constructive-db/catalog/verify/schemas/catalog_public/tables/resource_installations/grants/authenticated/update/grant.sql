-- Verify: schemas/catalog_public/tables/resource_installations/grants/authenticated/update/grant


SELECT verify_table_grant('catalog_public.resource_installations', 'UPDATE', 'authenticated');