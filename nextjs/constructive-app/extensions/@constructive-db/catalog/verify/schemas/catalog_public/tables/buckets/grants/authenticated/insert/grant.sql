-- Verify: schemas/catalog_public/tables/buckets/grants/authenticated/insert/grant


SELECT verify_table_grant('catalog_public.buckets', 'INSERT', 'authenticated');