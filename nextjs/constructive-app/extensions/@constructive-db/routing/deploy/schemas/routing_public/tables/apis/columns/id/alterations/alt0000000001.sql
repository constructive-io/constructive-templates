-- Deploy: schemas/routing_public/tables/apis/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/apis/table
-- requires: schemas/routing_public/tables/apis/columns/id/column


ALTER TABLE routing_public.apis 
  ALTER COLUMN id SET NOT NULL;