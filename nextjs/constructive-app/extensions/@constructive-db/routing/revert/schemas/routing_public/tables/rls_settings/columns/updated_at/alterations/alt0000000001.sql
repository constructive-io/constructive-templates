-- Revert: schemas/routing_public/tables/rls_settings/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.rls_settings 
  ALTER COLUMN updated_at DROP DEFAULT;