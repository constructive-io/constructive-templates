-- Revert: schemas/routing_public/tables/api_schemas/columns/api_id/alterations/alt0000000001


ALTER TABLE routing_public.api_schemas 
  ALTER COLUMN api_id DROP NOT NULL;