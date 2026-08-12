-- Revert: schemas/catalog_private/tables/functions/grants/authenticated/select/grant


REVOKE SELECT ON catalog_private.functions FROM authenticated RESTRICT;