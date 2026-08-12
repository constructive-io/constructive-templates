-- Revert: schemas/catalog_private/tables/sites_error_pages/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_private.sites_error_pages FROM authenticated RESTRICT;