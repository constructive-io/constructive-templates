-- Deploy: schemas/routing_public/tables/http_routes/columns/created_by/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/table


ALTER TABLE routing_public.http_routes 
  ADD COLUMN created_by uuid;