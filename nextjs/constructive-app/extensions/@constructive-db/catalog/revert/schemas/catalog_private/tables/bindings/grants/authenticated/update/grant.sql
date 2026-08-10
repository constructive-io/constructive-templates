-- Revert: schemas/catalog_private/tables/bindings/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_private.bindings FROM authenticated RESTRICT;