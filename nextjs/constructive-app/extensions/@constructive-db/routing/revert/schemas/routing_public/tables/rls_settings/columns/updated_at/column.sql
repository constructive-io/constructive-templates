-- Revert: schemas/routing_public/tables/rls_settings/columns/updated_at/column


ALTER TABLE routing_public.rls_settings 
  DROP COLUMN updated_at RESTRICT;