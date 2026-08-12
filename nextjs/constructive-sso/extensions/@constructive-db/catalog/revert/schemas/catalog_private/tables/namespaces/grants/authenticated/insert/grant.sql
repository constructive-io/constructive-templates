-- Revert: schemas/catalog_private/tables/namespaces/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_private.namespaces FROM authenticated RESTRICT;