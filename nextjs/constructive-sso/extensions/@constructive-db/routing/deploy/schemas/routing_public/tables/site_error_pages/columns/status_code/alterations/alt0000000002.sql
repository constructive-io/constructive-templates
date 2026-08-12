-- Deploy: schemas/routing_public/tables/site_error_pages/columns/status_code/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_error_pages/columns/status_code/column


COMMENT ON COLUMN routing_public.site_error_pages.status_code IS 'HTTP status code this custom page is served for (e.g. 404)';