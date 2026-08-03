-- Deploy: schemas/routing_public/tables/site_metadata/indexes/site_metadata_site_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_metadata/table
-- requires: schemas/routing_public/tables/site_metadata/columns/site_id/column


CREATE INDEX site_metadata_site_id_idx ON routing_public.site_metadata (site_id);