-- Revert: schemas/routing_public/tables/platform_api_settings/columns/statement_timeout_ms/column


ALTER TABLE routing_public.platform_api_settings 
  DROP COLUMN statement_timeout_ms RESTRICT;