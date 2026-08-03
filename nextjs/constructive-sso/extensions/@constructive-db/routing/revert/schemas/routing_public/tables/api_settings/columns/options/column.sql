-- Revert: schemas/routing_public/tables/api_settings/columns/options/column


ALTER TABLE routing_public.api_settings 
  DROP COLUMN options RESTRICT;