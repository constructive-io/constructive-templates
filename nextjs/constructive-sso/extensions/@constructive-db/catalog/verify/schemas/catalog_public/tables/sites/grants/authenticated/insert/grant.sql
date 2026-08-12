-- Verify: schemas/catalog_public/tables/sites/grants/authenticated/insert/grant


SELECT verify_table_grant('catalog_public.sites', 'INSERT', 'authenticated');