-- Deploy: schemas/routing_public/tables/webauthn_settings/indexes/webauthn_settings_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/webauthn_settings/table
-- requires: schemas/routing_public/tables/webauthn_settings/columns/updated_at/column


CREATE INDEX webauthn_settings_updated_at_idx ON routing_public.webauthn_settings (updated_at);