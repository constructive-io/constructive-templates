-- Deploy: schemas/routing_public/tables/platform_site_web_configs/indexes/platform_site_web_configs_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_web_configs/table
-- requires: schemas/routing_public/tables/platform_site_web_configs/columns/updated_at/column


CREATE INDEX platform_site_web_configs_updated_at_idx ON routing_public.platform_site_web_configs (updated_at);