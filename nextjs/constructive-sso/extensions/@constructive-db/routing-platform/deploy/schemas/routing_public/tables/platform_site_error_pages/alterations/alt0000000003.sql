-- Deploy: schemas/routing_public/tables/platform_site_error_pages/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_error_pages/table


COMMENT ON TABLE routing_public.platform_site_error_pages IS '@scope platform
@scopeTier global
Custom error pages for a site surface, keyed by HTTP status code';