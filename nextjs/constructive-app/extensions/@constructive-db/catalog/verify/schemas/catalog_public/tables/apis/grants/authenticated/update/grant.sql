-- Verify: schemas/catalog_public/tables/apis/grants/authenticated/update/grant


SELECT verify_table_grant('catalog_public.apis', 'UPDATE', 'authenticated');