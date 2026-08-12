-- Revert: schemas/catalog_private/tables/apps/grants/authenticated/select/grant


REVOKE SELECT ON catalog_private.apps FROM authenticated RESTRICT;