-- Revert: schemas/routing_public/tables/api_schemas/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.api_schemas 
  ALTER COLUMN updated_at DROP DEFAULT;