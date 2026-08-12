-- Revert: schemas/routing_public/tables/api_settings/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.api_settings 
  ALTER COLUMN id DROP DEFAULT;