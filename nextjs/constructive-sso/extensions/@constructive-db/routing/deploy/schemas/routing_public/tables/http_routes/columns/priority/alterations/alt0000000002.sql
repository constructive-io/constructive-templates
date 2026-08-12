-- Deploy: schemas/routing_public/tables/http_routes/columns/priority/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/table
-- requires: schemas/routing_public/tables/http_routes/columns/priority/column


ALTER TABLE routing_public.http_routes 
  ALTER COLUMN priority SET DEFAULT 0;