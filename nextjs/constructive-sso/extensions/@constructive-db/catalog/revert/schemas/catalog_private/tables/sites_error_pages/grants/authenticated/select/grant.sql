-- Revert: schemas/catalog_private/tables/sites_error_pages/grants/authenticated/select/grant


REVOKE SELECT ON catalog_private.sites_error_pages FROM authenticated RESTRICT;