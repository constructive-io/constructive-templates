-- Deploy: schemas/routing_public/tables/pubkey_settings/indexes/pubkey_settings_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pubkey_settings/table
-- requires: schemas/routing_public/tables/pubkey_settings/columns/created_at/column


CREATE INDEX pubkey_settings_created_at_idx ON routing_public.pubkey_settings (created_at);