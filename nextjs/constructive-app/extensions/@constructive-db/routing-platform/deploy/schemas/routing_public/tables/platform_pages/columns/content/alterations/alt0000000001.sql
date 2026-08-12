-- Deploy: schemas/routing_public/tables/platform_pages/columns/content/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_pages/table
-- requires: schemas/routing_public/tables/platform_pages/columns/content/column


ALTER TABLE routing_public.platform_pages 
  ALTER COLUMN content SET NOT NULL;