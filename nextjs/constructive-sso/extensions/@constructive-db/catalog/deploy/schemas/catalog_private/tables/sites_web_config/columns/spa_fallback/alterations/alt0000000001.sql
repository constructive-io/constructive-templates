-- Deploy: schemas/catalog_private/tables/sites_web_config/columns/spa_fallback/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/sites_web_config/columns/spa_fallback/column


COMMENT ON COLUMN catalog_private.sites_web_config.spa_fallback IS 'SPA fallback flag propagated from the source row (NULL = gateway default)';