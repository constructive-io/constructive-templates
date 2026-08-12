-- Revert: schemas/routing_public/tables/pubkey_settings/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.pubkey_settings 
  ALTER COLUMN id DROP DEFAULT;