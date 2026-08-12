-- Deploy: schemas/routing_public/tables/site_metadata/columns/commit_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_metadata/columns/commit_id/column


COMMENT ON COLUMN routing_public.site_metadata.commit_id IS 'Infra store commit for the current content (stamped by the versioned trigger on every write)';