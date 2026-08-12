-- Revert: schemas/routing_public/tables/api_schemas/columns/id/column


ALTER TABLE routing_public.api_schemas 
  DROP COLUMN id RESTRICT;