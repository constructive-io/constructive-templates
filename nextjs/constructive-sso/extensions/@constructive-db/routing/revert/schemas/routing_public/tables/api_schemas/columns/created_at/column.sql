-- Revert: schemas/routing_public/tables/api_schemas/columns/created_at/column


ALTER TABLE routing_public.api_schemas 
  DROP COLUMN created_at RESTRICT;