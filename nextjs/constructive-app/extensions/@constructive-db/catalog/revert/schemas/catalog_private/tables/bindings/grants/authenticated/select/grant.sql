-- Revert: schemas/catalog_private/tables/bindings/grants/authenticated/select/grant


REVOKE SELECT ON catalog_private.bindings FROM authenticated RESTRICT;