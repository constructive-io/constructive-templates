-- Deploy: schemas/routing_public/tables/site_web_configs/columns/spa_fallback/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_web_configs/columns/spa_fallback/column


COMMENT ON COLUMN routing_public.site_web_configs.spa_fallback IS 'Serve the index document (HTTP 200) for unmatched application deep links (NULL = gateway default)';