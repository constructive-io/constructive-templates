-- Revert: schemas/catalog_private/tables/apps/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_private.apps FROM authenticated RESTRICT;