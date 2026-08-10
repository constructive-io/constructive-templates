-- Revert: schemas/catalog_private/tables/functions/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_private.functions FROM authenticated RESTRICT;