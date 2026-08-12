-- Revert: schemas/catalog_private/tables/namespaces/grants/authenticated/select/grant


REVOKE SELECT ON catalog_private.namespaces FROM authenticated RESTRICT;