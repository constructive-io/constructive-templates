-- Revert: schemas/catalog_private/tables/apis/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_private.apis FROM authenticated RESTRICT;