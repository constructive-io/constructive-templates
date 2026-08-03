-- Revert: schemas/routing_public/tables/pubkey_settings/columns/database_id/column


ALTER TABLE routing_public.pubkey_settings 
  DROP COLUMN database_id RESTRICT;