-- Revert: schemas/routing_public/tables/pubkey_settings/columns/user_field/column


ALTER TABLE routing_public.pubkey_settings 
  DROP COLUMN user_field RESTRICT;