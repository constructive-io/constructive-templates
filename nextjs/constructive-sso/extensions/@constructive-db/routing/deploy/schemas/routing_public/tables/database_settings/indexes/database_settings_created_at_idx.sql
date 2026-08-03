-- Deploy: schemas/routing_public/tables/database_settings/indexes/database_settings_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/table
-- requires: schemas/routing_public/tables/database_settings/columns/created_at/column


CREATE INDEX database_settings_created_at_idx ON routing_public.database_settings (created_at);