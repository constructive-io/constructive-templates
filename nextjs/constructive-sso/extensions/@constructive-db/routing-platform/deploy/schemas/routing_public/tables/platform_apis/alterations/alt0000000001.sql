-- Deploy: schemas/routing_public/tables/platform_apis/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_apis/table


ALTER TABLE routing_public.platform_apis 
  DISABLE ROW LEVEL SECURITY;