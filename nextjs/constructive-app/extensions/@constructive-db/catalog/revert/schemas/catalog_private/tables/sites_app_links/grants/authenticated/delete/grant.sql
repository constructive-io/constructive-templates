-- Revert: schemas/catalog_private/tables/sites_app_links/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_private.sites_app_links FROM authenticated RESTRICT;