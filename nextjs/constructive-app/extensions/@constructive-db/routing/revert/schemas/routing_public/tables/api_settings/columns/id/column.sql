-- Revert: schemas/routing_public/tables/api_settings/columns/id/column


ALTER TABLE routing_public.api_settings 
  DROP COLUMN id RESTRICT;