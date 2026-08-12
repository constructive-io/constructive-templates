-- Deploy: schemas/routing_public/tables/site_web_configs/columns/clean_urls/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_web_configs/table


ALTER TABLE routing_public.site_web_configs 
  ADD COLUMN clean_urls boolean;