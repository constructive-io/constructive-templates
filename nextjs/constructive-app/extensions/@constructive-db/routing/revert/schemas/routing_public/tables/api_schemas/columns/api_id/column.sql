-- Revert: schemas/routing_public/tables/api_schemas/columns/api_id/column


ALTER TABLE routing_public.api_schemas 
  DROP COLUMN api_id RESTRICT;