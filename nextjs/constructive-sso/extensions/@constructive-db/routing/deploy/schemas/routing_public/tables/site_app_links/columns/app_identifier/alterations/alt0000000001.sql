-- Deploy: schemas/routing_public/tables/site_app_links/columns/app_identifier/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_app_links/table
-- requires: schemas/routing_public/tables/site_app_links/columns/app_identifier/column


ALTER TABLE routing_public.site_app_links 
  ALTER COLUMN app_identifier SET NOT NULL;