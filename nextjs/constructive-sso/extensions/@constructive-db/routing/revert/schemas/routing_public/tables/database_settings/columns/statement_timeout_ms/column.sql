-- Revert: schemas/routing_public/tables/database_settings/columns/statement_timeout_ms/column


ALTER TABLE routing_public.database_settings 
  DROP COLUMN statement_timeout_ms RESTRICT;