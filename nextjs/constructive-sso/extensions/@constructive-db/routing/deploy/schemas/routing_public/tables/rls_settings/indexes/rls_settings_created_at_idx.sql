-- Deploy: schemas/routing_public/tables/rls_settings/indexes/rls_settings_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/rls_settings/table
-- requires: schemas/routing_public/tables/rls_settings/columns/created_at/column


CREATE INDEX rls_settings_created_at_idx ON routing_public.rls_settings (created_at);