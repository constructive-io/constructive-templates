-- Deploy: schemas/routing_public/tables/site_deep_links/columns/web_path/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_deep_links/table


ALTER TABLE routing_public.site_deep_links 
  ADD COLUMN web_path text;