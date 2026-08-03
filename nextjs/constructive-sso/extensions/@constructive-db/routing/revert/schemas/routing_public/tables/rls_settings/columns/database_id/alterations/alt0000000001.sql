-- Revert: schemas/routing_public/tables/rls_settings/columns/database_id/alterations/alt0000000001


ALTER TABLE routing_public.rls_settings 
  ALTER COLUMN database_id DROP NOT NULL;