-- Deploy: schemas/routing_public/tables/site_error_pages/columns/site_id/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_error_pages/table


ALTER TABLE routing_public.site_error_pages 
  ADD COLUMN site_id uuid;