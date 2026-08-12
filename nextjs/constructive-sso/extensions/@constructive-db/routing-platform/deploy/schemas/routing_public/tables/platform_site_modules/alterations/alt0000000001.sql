-- Deploy: schemas/routing_public/tables/platform_site_modules/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_modules/table


ALTER TABLE routing_public.platform_site_modules 
  DISABLE ROW LEVEL SECURITY;