-- Deploy: schemas/routing_public/tables/sites/columns/created_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/sites/table
-- requires: schemas/routing_public/tables/sites/columns/created_at/column


ALTER TABLE routing_public.sites 
  ALTER COLUMN created_at SET DEFAULT now();