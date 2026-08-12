-- Deploy: schemas/routing_public/tables/apis/columns/id/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/apis/table


ALTER TABLE routing_public.apis 
  ADD COLUMN id uuid;