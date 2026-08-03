-- Verify: schemas/catalog_public/tables/resource_installations/grants/authenticated/delete/grant


SELECT verify_table_grant('catalog_public.resource_installations', 'DELETE', 'authenticated');