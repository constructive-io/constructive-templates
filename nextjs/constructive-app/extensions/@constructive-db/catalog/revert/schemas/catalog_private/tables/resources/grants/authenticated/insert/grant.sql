-- Revert: schemas/catalog_private/tables/resources/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_private.resources FROM authenticated RESTRICT;