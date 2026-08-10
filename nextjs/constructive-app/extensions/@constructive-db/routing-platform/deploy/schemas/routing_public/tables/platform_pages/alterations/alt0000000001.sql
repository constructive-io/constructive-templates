-- Deploy: schemas/routing_public/tables/platform_pages/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_pages/table


ALTER TABLE routing_public.platform_pages 
  DISABLE ROW LEVEL SECURITY;