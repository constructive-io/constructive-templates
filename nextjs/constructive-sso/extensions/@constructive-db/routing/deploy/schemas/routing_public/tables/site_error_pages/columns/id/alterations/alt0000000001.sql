-- Deploy: schemas/routing_public/tables/site_error_pages/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_error_pages/table
-- requires: schemas/routing_public/tables/site_error_pages/columns/id/column


ALTER TABLE routing_public.site_error_pages 
  ALTER COLUMN id SET NOT NULL;