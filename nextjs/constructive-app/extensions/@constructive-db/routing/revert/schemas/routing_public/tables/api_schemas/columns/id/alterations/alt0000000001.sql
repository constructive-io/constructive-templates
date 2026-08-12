-- Revert: schemas/routing_public/tables/api_schemas/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.api_schemas 
  ALTER COLUMN id DROP NOT NULL;