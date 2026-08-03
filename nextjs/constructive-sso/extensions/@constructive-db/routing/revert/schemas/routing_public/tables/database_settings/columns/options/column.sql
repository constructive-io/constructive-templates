-- Revert: schemas/routing_public/tables/database_settings/columns/options/column


ALTER TABLE routing_public.database_settings 
  DROP COLUMN options RESTRICT;