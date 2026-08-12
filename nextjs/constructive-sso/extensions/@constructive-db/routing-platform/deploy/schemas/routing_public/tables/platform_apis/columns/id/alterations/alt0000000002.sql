-- Deploy: schemas/routing_public/tables/platform_apis/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_apis/table
-- requires: schemas/routing_public/tables/platform_apis/columns/id/column


ALTER TABLE routing_public.platform_apis 
  ALTER COLUMN id SET DEFAULT uuidv7();