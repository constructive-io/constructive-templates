-- Verify: schemas/catalog_public/tables/apps/grants/authenticated/update/grant


SELECT verify_table_grant('catalog_public.apps', 'UPDATE', 'authenticated');