-- Deploy: schemas/routing_public/tables/pages/columns/slug/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pages/table


ALTER TABLE routing_public.pages 
  ADD COLUMN slug text;