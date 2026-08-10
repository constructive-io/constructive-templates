-- Deploy: schemas/routing_public/tables/site_metadata/columns/robots/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_metadata/table


ALTER TABLE routing_public.site_metadata 
  ADD COLUMN robots text;