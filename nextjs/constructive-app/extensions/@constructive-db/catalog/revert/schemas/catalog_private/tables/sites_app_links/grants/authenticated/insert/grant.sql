-- Revert: schemas/catalog_private/tables/sites_app_links/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_private.sites_app_links FROM authenticated RESTRICT;