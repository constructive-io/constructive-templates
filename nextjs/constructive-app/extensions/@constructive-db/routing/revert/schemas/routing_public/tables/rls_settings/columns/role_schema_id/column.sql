-- Revert: schemas/routing_public/tables/rls_settings/columns/role_schema_id/column


ALTER TABLE routing_public.rls_settings 
  DROP COLUMN role_schema_id RESTRICT;