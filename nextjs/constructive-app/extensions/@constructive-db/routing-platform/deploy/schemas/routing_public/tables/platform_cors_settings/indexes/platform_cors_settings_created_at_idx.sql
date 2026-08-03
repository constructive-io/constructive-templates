-- Deploy: schemas/routing_public/tables/platform_cors_settings/indexes/platform_cors_settings_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_cors_settings/table
-- requires: schemas/routing_public/tables/platform_cors_settings/columns/created_at/column


CREATE INDEX platform_cors_settings_created_at_idx ON routing_public.platform_cors_settings (created_at);