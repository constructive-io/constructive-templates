-- Verify: schemas/catalog_public/tables/resources/grants/authenticated/insert/grant


SELECT verify_table_grant('catalog_public.resources', 'INSERT', 'authenticated');