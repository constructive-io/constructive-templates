-- Deploy: schemas/routing_public/tables/pages/columns/site_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pages/columns/site_id/column


COMMENT ON COLUMN routing_public.pages.site_id IS 'Site surface this page belongs to; each site owns its own infra store and pages live at path [page, slug] within it';