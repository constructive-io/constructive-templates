-- Deploy: schemas/routing_public/tables/routes/columns/priority/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/table
-- requires: schemas/routing_public/tables/routes/columns/priority/column


ALTER TABLE routing_public.routes 
  ALTER COLUMN priority SET NOT NULL;