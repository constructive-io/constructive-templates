-- Deploy: schemas/routing_public/tables/site_app_links/columns/webcredentials/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_app_links/columns/webcredentials/column


COMMENT ON COLUMN routing_public.site_app_links.webcredentials IS 'Whether to emit the webcredentials service (iOS shared-web-credentials / password autofill)';