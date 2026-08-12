-- Deploy: schemas/routing_public/tables/platform_pages/columns/created_at/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_pages/table
-- requires: schemas/routing_public/tables/platform_pages/columns/created_at/column


ALTER TABLE routing_public.platform_pages 
  ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP;