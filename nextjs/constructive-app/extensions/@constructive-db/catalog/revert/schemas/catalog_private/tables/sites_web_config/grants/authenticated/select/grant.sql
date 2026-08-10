-- Revert: schemas/catalog_private/tables/sites_web_config/grants/authenticated/select/grant


REVOKE SELECT ON catalog_private.sites_web_config FROM authenticated RESTRICT;