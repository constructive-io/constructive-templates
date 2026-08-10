-- Deploy: schemas/routing_public/tables/site_web_configs/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_web_configs/table


COMMENT ON TABLE routing_public.site_web_configs IS '@scope database
@scopeKey database_id
@scopeTier database
Static-site serving configuration for a site surface (index document, clean URLs, SPA fallback)';