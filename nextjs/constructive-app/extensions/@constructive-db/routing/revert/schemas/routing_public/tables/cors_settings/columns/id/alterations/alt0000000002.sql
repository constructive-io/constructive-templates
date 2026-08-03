-- Revert: schemas/routing_public/tables/cors_settings/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.cors_settings 
  ALTER COLUMN id DROP DEFAULT;