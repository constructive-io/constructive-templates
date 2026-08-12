-- Deploy: schemas/routing_public/tables/platform_pages/columns/updated_at/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_pages/table
-- requires: schemas/routing_public/tables/platform_pages/columns/updated_at/column


ALTER TABLE routing_public.platform_pages 
  ALTER COLUMN updated_at SET DEFAULT CURRENT_TIMESTAMP;