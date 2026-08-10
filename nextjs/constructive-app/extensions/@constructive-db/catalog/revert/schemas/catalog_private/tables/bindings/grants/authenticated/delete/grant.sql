-- Revert: schemas/catalog_private/tables/bindings/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_private.bindings FROM authenticated RESTRICT;