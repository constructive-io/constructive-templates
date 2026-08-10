-- Revert: schemas/catalog_private/tables/sites_error_pages/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_private.sites_error_pages FROM authenticated RESTRICT;