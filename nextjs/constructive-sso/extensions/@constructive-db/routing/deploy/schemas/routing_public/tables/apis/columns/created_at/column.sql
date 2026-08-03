-- Deploy: schemas/routing_public/tables/apis/columns/created_at/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/apis/table


ALTER TABLE routing_public.apis 
  ADD COLUMN created_at timestamptz;