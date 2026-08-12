-- Verify: schemas/catalog_public/tables/buckets/grants/authenticated/update/grant


SELECT verify_table_grant('catalog_public.buckets', 'UPDATE', 'authenticated');