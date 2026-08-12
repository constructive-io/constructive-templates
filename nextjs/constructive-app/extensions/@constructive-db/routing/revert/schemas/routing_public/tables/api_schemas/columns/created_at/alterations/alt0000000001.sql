-- Revert: schemas/routing_public/tables/api_schemas/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.api_schemas 
  ALTER COLUMN created_at DROP DEFAULT;