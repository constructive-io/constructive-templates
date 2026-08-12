-- Revert: schemas/catalog_private/tables/sites_deep_links/grants/authenticated/select/grant


REVOKE SELECT ON catalog_private.sites_deep_links FROM authenticated RESTRICT;