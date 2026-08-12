-- Deploy: schemas/routing_public/tables/http_routes/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/table


ALTER TABLE routing_public.http_routes 
  DISABLE ROW LEVEL SECURITY;