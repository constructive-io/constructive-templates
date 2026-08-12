-- Revert: schemas/catalog_private/tables/sites_deep_links/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_private.sites_deep_links FROM authenticated RESTRICT;