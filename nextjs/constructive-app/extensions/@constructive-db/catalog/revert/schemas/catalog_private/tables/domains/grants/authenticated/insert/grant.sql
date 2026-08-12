-- Revert: schemas/catalog_private/tables/domains/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_private.domains FROM authenticated RESTRICT;