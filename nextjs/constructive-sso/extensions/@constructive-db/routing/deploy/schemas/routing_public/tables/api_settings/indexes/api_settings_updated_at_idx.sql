-- Deploy: schemas/routing_public/tables/api_settings/indexes/api_settings_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_settings/table
-- requires: schemas/routing_public/tables/api_settings/columns/updated_at/column


CREATE INDEX api_settings_updated_at_idx ON routing_public.api_settings (updated_at);