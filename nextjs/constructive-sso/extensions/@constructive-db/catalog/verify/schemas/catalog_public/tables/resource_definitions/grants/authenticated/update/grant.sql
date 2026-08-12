-- Verify: schemas/catalog_public/tables/resource_definitions/grants/authenticated/update/grant


SELECT verify_table_grant('catalog_public.resource_definitions', 'UPDATE', 'authenticated');