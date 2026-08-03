-- Verify: schemas/catalog_public/tables/resource_installations/grants/authenticated/insert/grant


SELECT verify_table_grant('catalog_public.resource_installations', 'INSERT', 'authenticated');