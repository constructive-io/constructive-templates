-- Deploy: schemas/routing_public/tables/cors_settings/indexes/cors_settings_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/cors_settings/table
-- requires: schemas/routing_public/tables/cors_settings/columns/updated_at/column


CREATE INDEX cors_settings_updated_at_idx ON routing_public.cors_settings (updated_at);