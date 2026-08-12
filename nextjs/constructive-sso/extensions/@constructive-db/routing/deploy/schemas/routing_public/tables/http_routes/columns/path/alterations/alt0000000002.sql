-- Deploy: schemas/routing_public/tables/http_routes/columns/path/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/table
-- requires: schemas/routing_public/tables/http_routes/columns/path/column


ALTER TABLE routing_public.http_routes 
  ALTER COLUMN path SET DEFAULT '/';