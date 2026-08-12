-- Revert: schemas/catalog_private/tables/sites_deep_links/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_private.sites_deep_links FROM authenticated RESTRICT;