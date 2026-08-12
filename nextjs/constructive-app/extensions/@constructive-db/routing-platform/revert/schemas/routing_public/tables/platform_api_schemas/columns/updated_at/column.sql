-- Revert: schemas/routing_public/tables/platform_api_schemas/columns/updated_at/column


ALTER TABLE routing_public.platform_api_schemas 
  DROP COLUMN updated_at RESTRICT;