-- Deploy: schemas/routing_public/tables/api_settings/indexes/api_settings_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_settings/table
-- requires: schemas/routing_public/tables/api_settings/columns/database_id/column


CREATE INDEX api_settings_database_id_idx ON routing_public.api_settings (database_id);