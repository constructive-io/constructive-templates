-- Revert: schemas/catalog_private/tables/buckets/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_private.buckets FROM authenticated RESTRICT;