-- Deploy: schemas/routing_public/tables/site_web_configs/indexes/site_web_configs_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_web_configs/table
-- requires: schemas/routing_public/tables/site_web_configs/columns/database_id/column


CREATE INDEX site_web_configs_database_id_idx ON routing_public.site_web_configs (database_id);