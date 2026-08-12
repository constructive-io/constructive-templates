-- Deploy: schemas/routing_public/tables/site_app_links/indexes/site_app_links_database_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_app_links/table
-- requires: schemas/routing_public/tables/site_app_links/columns/database_id/column


CREATE INDEX site_app_links_database_id_idx ON routing_public.site_app_links (database_id);