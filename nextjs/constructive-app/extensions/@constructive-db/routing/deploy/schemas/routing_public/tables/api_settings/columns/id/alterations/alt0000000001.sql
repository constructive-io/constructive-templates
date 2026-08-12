-- Deploy: schemas/routing_public/tables/api_settings/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_settings/table
-- requires: schemas/routing_public/tables/api_settings/columns/id/column


ALTER TABLE routing_public.api_settings 
  ALTER COLUMN id SET NOT NULL;