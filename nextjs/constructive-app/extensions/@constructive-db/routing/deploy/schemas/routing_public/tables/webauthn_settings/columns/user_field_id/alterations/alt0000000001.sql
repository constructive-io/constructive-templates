-- Deploy: schemas/routing_public/tables/webauthn_settings/columns/user_field_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/columns/user_field_id/column


COMMENT ON COLUMN routing_public.webauthn_settings.user_field_id IS 'Reference to the user field on webauthn_credentials (FK to metaschema_public.field)';