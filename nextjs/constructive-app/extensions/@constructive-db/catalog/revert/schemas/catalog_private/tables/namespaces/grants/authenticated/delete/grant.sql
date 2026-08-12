-- Revert: schemas/catalog_private/tables/namespaces/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_private.namespaces FROM authenticated RESTRICT;