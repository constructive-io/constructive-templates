-- Verify: schemas/catalog_public/tables/sites/grants/authenticated/update/grant


SELECT verify_table_grant('catalog_public.sites', 'UPDATE', 'authenticated');