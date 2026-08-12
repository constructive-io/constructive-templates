-- Deploy: schemas/routing_public/tables/site_metadata/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_metadata/table


COMMENT ON TABLE routing_public.site_metadata IS '@scope database
@scopeKey database_id
@scopeTier database
SEO and social sharing metadata for a site surface';