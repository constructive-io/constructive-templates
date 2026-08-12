-- Deploy: schemas/routing_public/tables/pages/columns/content/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pages/columns/content/column


COMMENT ON COLUMN routing_public.pages.content IS 'Page content (blocks/markdown/whatever the build consumes) — the readily-cached head; history lives in the infra store';