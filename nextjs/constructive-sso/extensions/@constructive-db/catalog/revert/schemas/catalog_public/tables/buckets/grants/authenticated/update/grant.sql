-- Revert: schemas/catalog_public/tables/buckets/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_public.buckets FROM authenticated RESTRICT;