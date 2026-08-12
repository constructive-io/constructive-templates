-- Deploy: schemas/routing_public/tables/site_metadata/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_metadata/table


ALTER TABLE routing_public.site_metadata 
  DISABLE ROW LEVEL SECURITY;