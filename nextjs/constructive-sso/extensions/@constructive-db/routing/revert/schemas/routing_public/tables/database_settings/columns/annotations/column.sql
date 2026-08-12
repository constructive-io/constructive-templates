-- Revert: schemas/routing_public/tables/database_settings/columns/annotations/column


ALTER TABLE routing_public.database_settings 
  DROP COLUMN annotations RESTRICT;