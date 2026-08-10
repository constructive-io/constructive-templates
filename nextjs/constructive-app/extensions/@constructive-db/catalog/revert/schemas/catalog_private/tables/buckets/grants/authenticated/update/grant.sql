-- Revert: schemas/catalog_private/tables/buckets/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_private.buckets FROM authenticated RESTRICT;