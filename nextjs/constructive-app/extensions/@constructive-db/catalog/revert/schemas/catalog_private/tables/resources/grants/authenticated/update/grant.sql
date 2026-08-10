-- Revert: schemas/catalog_private/tables/resources/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_private.resources FROM authenticated RESTRICT;