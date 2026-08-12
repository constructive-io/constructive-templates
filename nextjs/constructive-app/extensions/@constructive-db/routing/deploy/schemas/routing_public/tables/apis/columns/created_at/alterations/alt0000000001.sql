-- Deploy: schemas/routing_public/tables/apis/columns/created_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/apis/table
-- requires: schemas/routing_public/tables/apis/columns/created_at/column


ALTER TABLE routing_public.apis 
  ALTER COLUMN created_at SET DEFAULT now();