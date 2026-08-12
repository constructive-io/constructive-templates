-- Revert: schemas/catalog_private/tables/apis/grants/authenticated/select/grant


REVOKE SELECT ON catalog_private.apis FROM authenticated RESTRICT;