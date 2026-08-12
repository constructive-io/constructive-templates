-- Revert: schemas/catalog_public/tables/buckets/grants/authenticated/select/grant


REVOKE SELECT ON catalog_public.buckets FROM authenticated RESTRICT;