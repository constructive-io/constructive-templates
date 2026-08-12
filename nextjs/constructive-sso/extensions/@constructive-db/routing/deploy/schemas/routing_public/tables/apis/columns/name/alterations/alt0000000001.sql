-- Deploy: schemas/routing_public/tables/apis/columns/name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/apis/table
-- requires: schemas/routing_public/tables/apis/columns/name/column


ALTER TABLE routing_public.apis 
  ALTER COLUMN name SET NOT NULL;