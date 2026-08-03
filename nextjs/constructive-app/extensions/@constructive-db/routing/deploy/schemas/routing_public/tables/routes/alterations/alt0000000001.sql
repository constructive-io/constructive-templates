-- Deploy: schemas/routing_public/tables/routes/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/table


ALTER TABLE routing_public.routes 
  DISABLE ROW LEVEL SECURITY;