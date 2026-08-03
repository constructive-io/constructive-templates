-- Deploy: schemas/routing_public/tables/apis/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/apis/table


ALTER TABLE routing_public.apis 
  DISABLE ROW LEVEL SECURITY;