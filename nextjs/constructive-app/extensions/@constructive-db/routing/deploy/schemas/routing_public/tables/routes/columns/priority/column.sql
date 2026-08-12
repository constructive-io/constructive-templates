-- Deploy: schemas/routing_public/tables/routes/columns/priority/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/table


ALTER TABLE routing_public.routes 
  ADD COLUMN priority int;