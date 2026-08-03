-- Revert: schemas/routing_public/tables/api_schemas/columns/updated_at/column


ALTER TABLE routing_public.api_schemas 
  DROP COLUMN updated_at RESTRICT;