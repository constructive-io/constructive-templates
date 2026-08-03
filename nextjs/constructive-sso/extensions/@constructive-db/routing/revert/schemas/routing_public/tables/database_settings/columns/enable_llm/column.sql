-- Revert: schemas/routing_public/tables/database_settings/columns/enable_llm/column


ALTER TABLE routing_public.database_settings 
  DROP COLUMN enable_llm RESTRICT;