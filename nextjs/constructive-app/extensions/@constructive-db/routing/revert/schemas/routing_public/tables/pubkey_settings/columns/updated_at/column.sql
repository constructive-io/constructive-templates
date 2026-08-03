-- Revert: schemas/routing_public/tables/pubkey_settings/columns/updated_at/column


ALTER TABLE routing_public.pubkey_settings 
  DROP COLUMN updated_at RESTRICT;