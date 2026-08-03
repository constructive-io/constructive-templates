-- Revert: schemas/routing_public/tables/rls_settings/columns/created_at/column


ALTER TABLE routing_public.rls_settings 
  DROP COLUMN created_at RESTRICT;