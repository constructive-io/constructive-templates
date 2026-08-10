-- Revert: schemas/catalog_private/tables/apis/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_private.apis FROM authenticated RESTRICT;