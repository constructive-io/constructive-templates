-- Deploy: schemas/routing_public/tables/api_settings/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_settings/table


COMMENT ON TABLE routing_public.api_settings IS 'Per-API feature flag overrides; NULL columns inherit from database_settings';