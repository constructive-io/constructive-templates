-- Revert: schemas/catalog_private/tables/sites_app_links/grants/authenticated/select/grant


REVOKE SELECT ON catalog_private.sites_app_links FROM authenticated RESTRICT;