-- Verify: schemas/catalog_public/tables/resource_definitions/grants/authenticated/delete/grant


SELECT verify_table_grant('catalog_public.resource_definitions', 'DELETE', 'authenticated');