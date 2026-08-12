-- Revert: schemas/routing_public/tables/rls_settings/columns/database_id/column


ALTER TABLE routing_public.rls_settings 
  DROP COLUMN database_id RESTRICT;