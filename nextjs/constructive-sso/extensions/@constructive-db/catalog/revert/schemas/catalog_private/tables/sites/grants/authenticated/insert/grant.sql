-- Revert: schemas/catalog_private/tables/sites/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_private.sites FROM authenticated RESTRICT;