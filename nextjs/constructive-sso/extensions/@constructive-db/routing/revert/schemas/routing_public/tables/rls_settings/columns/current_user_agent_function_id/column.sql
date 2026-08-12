-- Revert: schemas/routing_public/tables/rls_settings/columns/current_user_agent_function_id/column


ALTER TABLE routing_public.rls_settings 
  DROP COLUMN current_user_agent_function_id RESTRICT;