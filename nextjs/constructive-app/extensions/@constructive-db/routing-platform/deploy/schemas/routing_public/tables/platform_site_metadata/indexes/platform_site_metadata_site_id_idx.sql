-- Deploy: schemas/routing_public/tables/platform_site_metadata/indexes/platform_site_metadata_site_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_metadata/table
-- requires: schemas/routing_public/tables/platform_site_metadata/columns/site_id/column


CREATE INDEX platform_site_metadata_site_id_idx ON routing_public.platform_site_metadata (site_id);