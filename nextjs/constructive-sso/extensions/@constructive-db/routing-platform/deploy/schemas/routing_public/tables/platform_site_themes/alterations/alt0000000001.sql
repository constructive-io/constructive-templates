-- Deploy: schemas/routing_public/tables/platform_site_themes/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_themes/table


ALTER TABLE routing_public.platform_site_themes 
  DISABLE ROW LEVEL SECURITY;