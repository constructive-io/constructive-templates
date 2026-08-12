-- Deploy: schemas/routing_public/tables/cors_settings/columns/id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/cors_settings/table
-- requires: schemas/routing_public/tables/cors_settings/columns/id/column


ALTER TABLE routing_public.cors_settings 
  ALTER COLUMN id SET DEFAULT uuidv7();