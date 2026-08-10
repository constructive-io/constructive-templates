-- Deploy: schemas/routing_public/tables/platform_site_app_links/indexes/platform_site_app_links_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_app_links/table
-- requires: schemas/routing_public/tables/platform_site_app_links/columns/updated_at/column


CREATE INDEX platform_site_app_links_updated_at_idx ON routing_public.platform_site_app_links (updated_at);