-- Revert: schemas/catalog_private/tables/apps/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_private.apps FROM authenticated RESTRICT;