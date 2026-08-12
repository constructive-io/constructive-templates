-- Revert: schemas/catalog_private/tables/resources/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_private.resources FROM authenticated RESTRICT;