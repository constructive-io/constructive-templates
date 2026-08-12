-- Deploy: schemas/routing_public/tables/site_app_links/columns/path_components/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_app_links/columns/path_components/column


COMMENT ON COLUMN routing_public.site_app_links.path_components IS 'Path patterns this association applies to (AASA paths / Android intent-filter paths)';