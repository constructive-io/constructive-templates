-- Deploy: schemas/routing_public/tables/pages/columns/updated_at/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pages/table


ALTER TABLE routing_public.pages 
  ADD COLUMN updated_at timestamptz;