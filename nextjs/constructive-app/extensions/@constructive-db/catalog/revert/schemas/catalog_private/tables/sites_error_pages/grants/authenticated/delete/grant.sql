-- Revert: schemas/catalog_private/tables/sites_error_pages/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_private.sites_error_pages FROM authenticated RESTRICT;