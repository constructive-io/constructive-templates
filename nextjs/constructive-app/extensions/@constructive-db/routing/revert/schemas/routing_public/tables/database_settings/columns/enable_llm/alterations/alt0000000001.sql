-- Revert: schemas/routing_public/tables/database_settings/columns/enable_llm/alterations/alt0000000001


ALTER TABLE routing_public.database_settings 
  ALTER COLUMN enable_llm DROP NOT NULL;