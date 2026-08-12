-- Revert: schemas/routing_public/tables/pubkey_settings/columns/created_at/column


ALTER TABLE routing_public.pubkey_settings 
  DROP COLUMN created_at RESTRICT;