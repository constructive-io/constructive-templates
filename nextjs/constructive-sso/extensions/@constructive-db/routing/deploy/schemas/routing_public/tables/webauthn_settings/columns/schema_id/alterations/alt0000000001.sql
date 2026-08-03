-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/schema_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/columns/schema_id/column


COMMENT ON COLUMN routing_public.webauthn_settings.schema_id IS 'Schema containing WebAuthn auth procedures (FK to metaschema_public.schema)';