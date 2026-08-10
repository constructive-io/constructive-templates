-- Deploy: schemas/routing_public/tables/platform_site_deep_links/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_deep_links/table
-- requires: schemas/routing_public/tables/platform_site_deep_links/columns/id/column


ALTER TABLE routing_public.platform_site_deep_links 
  ALTER COLUMN id SET NOT NULL;