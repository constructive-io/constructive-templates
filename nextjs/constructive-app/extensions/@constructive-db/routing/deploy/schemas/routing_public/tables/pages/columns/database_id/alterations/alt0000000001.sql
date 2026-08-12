-- Deploy: schemas/routing_public/tables/pages/columns/database_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pages/table
-- requires: schemas/routing_public/tables/pages/columns/database_id/column


ALTER TABLE routing_public.pages 
  ALTER COLUMN database_id SET NOT NULL;