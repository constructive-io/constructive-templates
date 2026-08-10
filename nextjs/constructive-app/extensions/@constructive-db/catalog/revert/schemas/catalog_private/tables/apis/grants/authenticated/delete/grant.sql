-- Revert: schemas/catalog_private/tables/apis/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_private.apis FROM authenticated RESTRICT;