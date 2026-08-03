-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/credentials_schema_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/columns/credentials_schema_id/column


COMMENT ON COLUMN routing_public.webauthn_settings.credentials_schema_id IS 'Schema of the webauthn_credentials table (FK to metaschema_public.schema)';