-- Deploy: schemas/routing_public/tables/site_error_pages/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_error_pages/table


ALTER TABLE routing_public.site_error_pages 
  DISABLE ROW LEVEL SECURITY;