-- Deploy: schemas/routing_public/tables/platform_site_error_pages/columns/status_code/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_error_pages/table


ALTER TABLE routing_public.platform_site_error_pages 
  ADD COLUMN status_code int;