-- Revert: schemas/catalog_private/tables/namespaces/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_private.namespaces FROM authenticated RESTRICT;