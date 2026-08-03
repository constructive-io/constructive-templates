-- Revert: schemas/routing_public/tables/api_schemas/columns/database_id/alterations/alt0000000001


ALTER TABLE routing_public.api_schemas 
  ALTER COLUMN database_id DROP NOT NULL;