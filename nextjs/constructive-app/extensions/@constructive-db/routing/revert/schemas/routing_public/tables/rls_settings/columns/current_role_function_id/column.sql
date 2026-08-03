-- Revert: schemas/routing_public/tables/rls_settings/columns/current_role_function_id/column


ALTER TABLE routing_public.rls_settings 
  DROP COLUMN current_role_function_id RESTRICT;