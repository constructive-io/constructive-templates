-- Deploy: schemas/routing_public/tables/pages/columns/created_at/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pages/table
-- requires: schemas/routing_public/tables/pages/columns/created_at/column


ALTER TABLE routing_public.pages 
  ALTER COLUMN created_at SET DEFAULT CURRENT_TIMESTAMP;