-- Deploy: schemas/routing_public/tables/site_deep_links/columns/fallback_url/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_deep_links/table


ALTER TABLE routing_public.site_deep_links 
  ADD COLUMN fallback_url text;