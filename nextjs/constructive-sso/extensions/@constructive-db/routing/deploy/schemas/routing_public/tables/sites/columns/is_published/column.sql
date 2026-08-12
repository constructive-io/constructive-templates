-- Deploy: schemas/routing_public/tables/sites/columns/is_published/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/sites/table


ALTER TABLE routing_public.sites 
  ADD COLUMN is_published boolean;