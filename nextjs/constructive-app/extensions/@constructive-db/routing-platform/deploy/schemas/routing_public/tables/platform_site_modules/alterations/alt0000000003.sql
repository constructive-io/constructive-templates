-- Deploy: schemas/routing_public/tables/platform_site_modules/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_modules/table


COMMENT ON TABLE routing_public.platform_site_modules IS '@scope platform
@scopeTier global
Frontend module configuration for a site surface; stores module name and JSON settings';