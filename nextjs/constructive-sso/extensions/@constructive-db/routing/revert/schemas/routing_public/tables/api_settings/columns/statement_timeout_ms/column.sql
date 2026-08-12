-- Revert: schemas/routing_public/tables/api_settings/columns/statement_timeout_ms/column


ALTER TABLE routing_public.api_settings 
  DROP COLUMN statement_timeout_ms RESTRICT;