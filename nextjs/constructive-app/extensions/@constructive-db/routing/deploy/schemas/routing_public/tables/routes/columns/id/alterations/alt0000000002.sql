-- Deploy: schemas/routing_public/tables/routes/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/table
-- requires: schemas/routing_public/tables/routes/columns/id/column


ALTER TABLE routing_public.routes 
  ALTER COLUMN id SET DEFAULT uuidv7();