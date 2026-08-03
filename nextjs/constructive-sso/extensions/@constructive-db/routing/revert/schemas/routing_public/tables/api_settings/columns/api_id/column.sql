-- Revert: schemas/routing_public/tables/api_settings/columns/api_id/column


ALTER TABLE routing_public.api_settings 
  DROP COLUMN api_id RESTRICT;