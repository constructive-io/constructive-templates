-- Deploy: schemas/routing_public/tables/platform_domains/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_domains/table


ALTER TABLE routing_public.platform_domains 
  DISABLE ROW LEVEL SECURITY;