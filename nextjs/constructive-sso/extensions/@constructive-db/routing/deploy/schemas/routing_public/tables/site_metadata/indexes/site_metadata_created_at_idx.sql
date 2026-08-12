-- Deploy: schemas/routing_public/tables/site_metadata/indexes/site_metadata_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_metadata/table
-- requires: schemas/routing_public/tables/site_metadata/columns/created_at/column


CREATE INDEX site_metadata_created_at_idx ON routing_public.site_metadata (created_at);