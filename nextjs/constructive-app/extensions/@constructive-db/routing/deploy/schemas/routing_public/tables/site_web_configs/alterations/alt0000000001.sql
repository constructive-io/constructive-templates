-- Deploy: schemas/routing_public/tables/site_web_configs/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_web_configs/table


ALTER TABLE routing_public.site_web_configs 
  DISABLE ROW LEVEL SECURITY;