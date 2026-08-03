-- Deploy: schemas/routing_public/tables/api_settings/columns/api_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_settings/table
-- requires: schemas/routing_public/tables/api_settings/columns/api_id/column


ALTER TABLE routing_public.api_settings 
  ALTER COLUMN api_id SET NOT NULL;