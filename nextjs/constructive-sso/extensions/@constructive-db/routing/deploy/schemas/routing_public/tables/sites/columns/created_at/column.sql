-- Deploy: schemas/routing_public/tables/sites/columns/created_at/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/sites/table


ALTER TABLE routing_public.sites 
  ADD COLUMN created_at timestamptz;