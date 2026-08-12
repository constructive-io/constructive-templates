-- Revert: schemas/catalog_private/tables/sites_deep_links/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_private.sites_deep_links FROM authenticated RESTRICT;