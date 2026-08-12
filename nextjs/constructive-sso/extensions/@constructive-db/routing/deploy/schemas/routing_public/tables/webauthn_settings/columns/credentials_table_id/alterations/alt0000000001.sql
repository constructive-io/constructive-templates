-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/credentials_table_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/columns/credentials_table_id/column


COMMENT ON COLUMN routing_public.webauthn_settings.credentials_table_id IS 'Reference to the webauthn_credentials table (FK to metaschema_public.table)';