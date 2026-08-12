-- Deploy: schemas/routing_public/tables/domains/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domains/table


ALTER TABLE routing_public.domains 
  DISABLE ROW LEVEL SECURITY;