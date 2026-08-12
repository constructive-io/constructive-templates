-- Verify: schemas/catalog_public/tables/resources/grants/authenticated/update/grant


SELECT verify_table_grant('catalog_public.resources', 'UPDATE', 'authenticated');