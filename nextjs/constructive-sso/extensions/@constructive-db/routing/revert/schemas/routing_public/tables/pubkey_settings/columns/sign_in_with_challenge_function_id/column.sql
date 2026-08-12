-- Revert: schemas/routing_public/tables/pubkey_settings/columns/sign_in_with_challenge_function_id/column


ALTER TABLE routing_public.pubkey_settings 
  DROP COLUMN sign_in_with_challenge_function_id RESTRICT;