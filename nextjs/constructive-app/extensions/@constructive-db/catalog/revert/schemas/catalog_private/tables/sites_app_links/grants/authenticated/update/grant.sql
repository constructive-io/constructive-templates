-- Revert: schemas/catalog_private/tables/sites_app_links/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_private.sites_app_links FROM authenticated RESTRICT;