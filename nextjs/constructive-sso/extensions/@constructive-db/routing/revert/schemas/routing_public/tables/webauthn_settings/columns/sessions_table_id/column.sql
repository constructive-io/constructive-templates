-- Revert: schemas/routing_public/tables/webauthn_settings/columns/sessions_table_id/column


ALTER TABLE routing_public.webauthn_settings 
  DROP COLUMN sessions_table_id RESTRICT;