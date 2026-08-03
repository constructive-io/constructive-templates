-- Revert: schemas/routing_public/tables/rls_settings/columns/id/column


ALTER TABLE routing_public.rls_settings 
  DROP COLUMN id RESTRICT;