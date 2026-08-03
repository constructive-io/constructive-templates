-- Revert: schemas/routing_public/tables/pubkey_settings/columns/schema_id/column


ALTER TABLE routing_public.pubkey_settings 
  DROP COLUMN schema_id RESTRICT;