-- Revert: schemas/catalog_private/tables/sites/grants/authenticated/select/grant


REVOKE SELECT ON catalog_private.sites FROM authenticated RESTRICT;