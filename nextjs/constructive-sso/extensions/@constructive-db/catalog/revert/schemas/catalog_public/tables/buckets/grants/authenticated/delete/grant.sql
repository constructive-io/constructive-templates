-- Revert: schemas/catalog_public/tables/buckets/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_public.buckets FROM authenticated RESTRICT;