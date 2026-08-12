-- Revert: schemas/catalog_private/tables/apps/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_private.apps FROM authenticated RESTRICT;