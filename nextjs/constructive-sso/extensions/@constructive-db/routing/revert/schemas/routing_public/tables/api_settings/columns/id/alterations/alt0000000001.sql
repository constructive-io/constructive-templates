-- Revert: schemas/routing_public/tables/api_settings/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.api_settings 
  ALTER COLUMN id DROP NOT NULL;