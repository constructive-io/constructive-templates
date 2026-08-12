-- Deploy: schemas/routing_public/tables/site_error_pages/columns/object_path/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_error_pages/table


ALTER TABLE routing_public.site_error_pages 
  ADD COLUMN object_path text;