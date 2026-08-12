-- Verify: schemas/catalog_public/tables/sites/grants/authenticated/delete/grant


SELECT verify_table_grant('catalog_public.sites', 'DELETE', 'authenticated');