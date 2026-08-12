-- Deploy: schemas/routing_public/tables/sites/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/sites/table


ALTER TABLE routing_public.sites 
  DISABLE ROW LEVEL SECURITY;