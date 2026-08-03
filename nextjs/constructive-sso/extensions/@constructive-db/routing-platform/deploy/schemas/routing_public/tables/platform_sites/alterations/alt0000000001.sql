-- Deploy: schemas/routing_public/tables/platform_sites/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_sites/table


ALTER TABLE routing_public.platform_sites 
  DISABLE ROW LEVEL SECURITY;