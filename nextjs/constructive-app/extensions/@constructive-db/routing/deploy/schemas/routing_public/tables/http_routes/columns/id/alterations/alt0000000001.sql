-- Deploy: schemas/routing_public/tables/http_routes/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/table
-- requires: schemas/routing_public/tables/http_routes/columns/id/column


ALTER TABLE routing_public.http_routes 
  ALTER COLUMN id SET NOT NULL;