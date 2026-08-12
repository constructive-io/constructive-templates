-- Revert: schemas/catalog_private/tables/sites_web_config/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_private.sites_web_config FROM authenticated RESTRICT;