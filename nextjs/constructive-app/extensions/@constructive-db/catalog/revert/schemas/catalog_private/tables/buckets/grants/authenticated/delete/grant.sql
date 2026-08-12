-- Revert: schemas/catalog_private/tables/buckets/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_private.buckets FROM authenticated RESTRICT;