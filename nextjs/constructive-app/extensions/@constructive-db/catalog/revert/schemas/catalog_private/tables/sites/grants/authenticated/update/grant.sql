-- Revert: schemas/catalog_private/tables/sites/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_private.sites FROM authenticated RESTRICT;