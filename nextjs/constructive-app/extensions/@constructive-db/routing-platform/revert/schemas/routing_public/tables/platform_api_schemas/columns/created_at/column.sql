-- Revert: schemas/routing_public/tables/platform_api_schemas/columns/created_at/column


ALTER TABLE routing_public.platform_api_schemas 
  DROP COLUMN created_at RESTRICT;