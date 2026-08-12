-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/session_credentials_table_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/columns/session_credentials_table_id/column


COMMENT ON COLUMN routing_public.webauthn_settings.session_credentials_table_id IS 'Reference to the session_credentials table (FK to metaschema_public.table)';