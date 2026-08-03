-- Revert: schemas/routing_public/tables/webauthn_settings/columns/user_field_id/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN user_field_id RESTRICT;