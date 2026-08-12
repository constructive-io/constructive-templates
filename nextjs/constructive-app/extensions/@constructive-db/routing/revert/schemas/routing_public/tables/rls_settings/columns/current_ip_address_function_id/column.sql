-- Revert: schemas/routing_public/tables/rls_settings/columns/current_ip_address_function_id/column


ALTER TABLE routing_public.rls_settings 
  DROP COLUMN current_ip_address_function_id RESTRICT;