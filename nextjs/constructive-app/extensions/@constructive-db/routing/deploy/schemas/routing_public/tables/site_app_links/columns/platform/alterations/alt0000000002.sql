-- Deploy: schemas/routing_public/tables/site_app_links/columns/platform/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_app_links/columns/platform/column


COMMENT ON COLUMN routing_public.site_app_links.platform IS 'Target platform for this association (ios, android)';