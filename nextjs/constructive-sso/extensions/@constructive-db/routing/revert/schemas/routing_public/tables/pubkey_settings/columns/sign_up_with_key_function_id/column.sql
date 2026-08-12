-- Revert: schemas/routing_public/tables/pubkey_settings/columns/sign_up_with_key_function_id/column


ALTER TABLE routing_public.pubkey_settings 
  DROP COLUMN sign_up_with_key_function_id RESTRICT;