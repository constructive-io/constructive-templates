-- Deploy: schemas/routing_public/tables/pages/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pages/table


ALTER TABLE routing_public.pages 
  DISABLE ROW LEVEL SECURITY;