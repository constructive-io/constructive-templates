-- Revert: schemas/routing_public/tables/rls_settings/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.rls_settings 
  ALTER COLUMN id DROP DEFAULT;