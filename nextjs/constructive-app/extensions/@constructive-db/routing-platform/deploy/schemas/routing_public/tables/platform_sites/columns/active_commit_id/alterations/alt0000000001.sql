-- Deploy: schemas/routing_public/tables/platform_sites/columns/active_commit_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_sites/columns/active_commit_id/column


COMMENT ON COLUMN routing_public.platform_sites.active_commit_id IS 'Infra-store commit pinned as the live page content for this site (manual publish pointer; NULL = nothing published yet)';