-- Deploy: schemas/routing_public/tables/http_routes/columns/is_active/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/table


ALTER TABLE routing_public.http_routes 
  ADD COLUMN is_active boolean;