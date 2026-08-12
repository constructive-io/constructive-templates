-- Revert: schemas/routing_public/tables/pubkey_settings/columns/id/column


ALTER TABLE routing_public.pubkey_settings 
  DROP COLUMN id RESTRICT;