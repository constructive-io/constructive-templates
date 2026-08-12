-- Revert: schemas/catalog_private/tables/functions/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_private.functions FROM authenticated RESTRICT;