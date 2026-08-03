-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/session_credentials_table_id/column
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/table


ALTER TABLE routing_public.webauthn_settings 
  ADD COLUMN session_credentials_table_id uuid;