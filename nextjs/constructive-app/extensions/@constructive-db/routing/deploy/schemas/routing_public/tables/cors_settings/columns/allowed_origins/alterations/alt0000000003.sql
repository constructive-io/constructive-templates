-- Deploy: schemas/routing_public/tables/cors_settings/columns/allowed_origins/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/cors_settings/columns/allowed_origins/column


COMMENT ON COLUMN routing_public.cors_settings.allowed_origins IS 'Array of allowed CORS origins (e.g. https://example.com)';