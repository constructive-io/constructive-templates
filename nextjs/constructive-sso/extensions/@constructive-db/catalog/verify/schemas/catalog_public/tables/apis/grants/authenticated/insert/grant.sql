-- Verify: schemas/catalog_public/tables/apis/grants/authenticated/insert/grant


SELECT verify_table_grant('catalog_public.apis', 'INSERT', 'authenticated');