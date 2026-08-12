-- Deploy: schemas/routing_public/tables/pages/columns/slug/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pages/columns/slug/column


COMMENT ON COLUMN routing_public.pages.slug IS 'Page slug (unique per site)';