-- Revert: schemas/catalog_private/tables/domains/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_private.domains FROM authenticated RESTRICT;