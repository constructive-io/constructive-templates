-- Deploy: schemas/routing_public/tables/platform_site_deep_links/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_deep_links/table


ALTER TABLE routing_public.platform_site_deep_links 
  DISABLE ROW LEVEL SECURITY;