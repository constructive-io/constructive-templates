-- Deploy: schemas/routing_public/tables/site_app_links/columns/app_identifier/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_app_links/table


ALTER TABLE routing_public.site_app_links 
  ADD COLUMN app_identifier text;