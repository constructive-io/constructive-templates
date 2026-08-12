-- Verify: schemas/catalog_public/tables/apis/grants/authenticated/delete/grant


SELECT verify_table_grant('catalog_public.apis', 'DELETE', 'authenticated');