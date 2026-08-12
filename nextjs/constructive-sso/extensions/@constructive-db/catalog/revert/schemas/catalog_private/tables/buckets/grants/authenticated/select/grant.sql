-- Revert: schemas/catalog_private/tables/buckets/grants/authenticated/select/grant


REVOKE SELECT ON catalog_private.buckets FROM authenticated RESTRICT;