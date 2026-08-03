-- Revert: schemas/routing_public/tables/webauthn_settings/columns/credentials_table_id/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN credentials_table_id RESTRICT;