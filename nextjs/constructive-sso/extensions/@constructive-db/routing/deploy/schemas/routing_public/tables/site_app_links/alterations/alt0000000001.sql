-- Deploy: schemas/routing_public/tables/site_app_links/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_app_links/table


ALTER TABLE routing_public.site_app_links 
  DISABLE ROW LEVEL SECURITY;