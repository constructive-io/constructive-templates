-- Revert: schemas/routing_public/tables/pubkey_settings/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.pubkey_settings 
  ALTER COLUMN updated_at DROP DEFAULT;