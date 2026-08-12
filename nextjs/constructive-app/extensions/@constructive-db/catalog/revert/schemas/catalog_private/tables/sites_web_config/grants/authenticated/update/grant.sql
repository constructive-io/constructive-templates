-- Revert: schemas/catalog_private/tables/sites_web_config/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_private.sites_web_config FROM authenticated RESTRICT;