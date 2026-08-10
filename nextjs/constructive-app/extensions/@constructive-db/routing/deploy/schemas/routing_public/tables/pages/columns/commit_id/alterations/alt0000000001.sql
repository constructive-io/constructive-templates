-- Deploy: schemas/routing_public/tables/pages/columns/commit_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pages/columns/commit_id/column


COMMENT ON COLUMN routing_public.pages.commit_id IS 'Infra store commit for the current content (stamped by the versioned trigger on every write)';