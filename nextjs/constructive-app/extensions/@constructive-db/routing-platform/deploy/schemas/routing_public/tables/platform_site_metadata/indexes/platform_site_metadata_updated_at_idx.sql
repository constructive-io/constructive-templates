-- Deploy: schemas/routing_public/tables/platform_site_metadata/indexes/platform_site_metadata_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_metadata/table
-- requires: schemas/routing_public/tables/platform_site_metadata/columns/updated_at/column


CREATE INDEX platform_site_metadata_updated_at_idx ON routing_public.platform_site_metadata (updated_at);