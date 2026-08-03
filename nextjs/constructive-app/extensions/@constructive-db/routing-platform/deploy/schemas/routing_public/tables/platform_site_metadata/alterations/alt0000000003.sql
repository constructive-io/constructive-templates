-- Deploy: schemas/routing_public/tables/platform_site_metadata/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_metadata/table


COMMENT ON TABLE routing_public.platform_site_metadata IS '@scope platform
@scopeTier global
SEO and social sharing metadata for a site surface';