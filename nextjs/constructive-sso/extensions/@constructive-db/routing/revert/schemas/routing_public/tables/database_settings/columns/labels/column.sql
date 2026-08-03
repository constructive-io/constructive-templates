-- Revert: schemas/routing_public/tables/database_settings/columns/labels/column


ALTER TABLE routing_public.database_settings 
  DROP COLUMN labels RESTRICT;