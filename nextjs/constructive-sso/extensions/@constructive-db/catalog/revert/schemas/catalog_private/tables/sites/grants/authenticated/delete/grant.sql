-- Revert: schemas/catalog_private/tables/sites/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_private.sites FROM authenticated RESTRICT;