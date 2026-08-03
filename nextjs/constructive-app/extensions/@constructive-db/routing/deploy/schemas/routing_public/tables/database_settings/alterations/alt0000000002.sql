-- Deploy: schemas/routing_public/tables/database_settings/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/table


COMMENT ON TABLE routing_public.database_settings IS 'Scope-wide feature flags and settings; controls which platform features are available to all APIs in this scope';