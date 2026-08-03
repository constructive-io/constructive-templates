-- Revert: schemas/catalog_public/tables/buckets/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_public.buckets FROM authenticated RESTRICT;