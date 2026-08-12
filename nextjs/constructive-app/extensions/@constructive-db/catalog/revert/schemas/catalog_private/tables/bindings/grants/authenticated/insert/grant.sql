-- Revert: schemas/catalog_private/tables/bindings/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_private.bindings FROM authenticated RESTRICT;