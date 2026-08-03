-- Verify: schemas/catalog_public/tables/buckets/grants/authenticated/select/grant


SELECT verify_table_grant('catalog_public.buckets', 'SELECT', 'authenticated');