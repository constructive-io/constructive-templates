-- Revert: schemas/routing_public/tables/rls_settings/columns/authenticate_function_id/column


ALTER TABLE routing_public.rls_settings 
  DROP COLUMN authenticate_function_id RESTRICT;