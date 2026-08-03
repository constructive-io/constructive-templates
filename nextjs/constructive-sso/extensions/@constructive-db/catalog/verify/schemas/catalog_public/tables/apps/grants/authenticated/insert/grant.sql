-- Verify: schemas/catalog_public/tables/apps/grants/authenticated/insert/grant


SELECT verify_table_grant('catalog_public.apps', 'INSERT', 'authenticated');