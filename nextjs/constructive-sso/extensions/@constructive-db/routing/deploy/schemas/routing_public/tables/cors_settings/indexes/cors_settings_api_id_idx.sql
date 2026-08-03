-- Deploy: schemas/routing_public/tables/cors_settings/indexes/cors_settings_api_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/cors_settings/table
-- requires: schemas/routing_public/tables/cors_settings/columns/api_id/column


CREATE INDEX cors_settings_api_id_idx ON routing_public.cors_settings (api_id);