-- Verify: schemas/catalog_public/tables/resources/grants/authenticated/delete/grant


SELECT verify_table_grant('catalog_public.resources', 'DELETE', 'authenticated');