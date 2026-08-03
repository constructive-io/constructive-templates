-- Verify: schemas/catalog_public/tables/buckets/grants/authenticated/delete/grant


SELECT verify_table_grant('catalog_public.buckets', 'DELETE', 'authenticated');