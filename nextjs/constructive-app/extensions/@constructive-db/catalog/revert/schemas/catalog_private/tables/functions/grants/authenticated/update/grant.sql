-- Revert: schemas/catalog_private/tables/functions/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_private.functions FROM authenticated RESTRICT;