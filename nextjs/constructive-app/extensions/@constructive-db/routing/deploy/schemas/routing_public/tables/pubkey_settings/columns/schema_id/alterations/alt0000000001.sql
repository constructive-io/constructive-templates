-- Deploy: schemas/routing_public/tables/pubkey_settings/columns/schema_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pubkey_settings/columns/schema_id/column


COMMENT ON COLUMN routing_public.pubkey_settings.schema_id IS 'Schema containing the crypto auth functions (FK to metaschema_public.schema)';