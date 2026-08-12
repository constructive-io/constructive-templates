-- Revert: schemas/catalog_private/tables/sites_web_config/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_private.sites_web_config FROM authenticated RESTRICT;