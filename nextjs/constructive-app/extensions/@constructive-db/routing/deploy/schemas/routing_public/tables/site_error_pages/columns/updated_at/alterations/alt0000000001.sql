-- Deploy: schemas/routing_public/tables/site_error_pages/columns/updated_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_error_pages/table
-- requires: schemas/routing_public/tables/site_error_pages/columns/updated_at/column


ALTER TABLE routing_public.site_error_pages 
  ALTER COLUMN updated_at SET DEFAULT now();