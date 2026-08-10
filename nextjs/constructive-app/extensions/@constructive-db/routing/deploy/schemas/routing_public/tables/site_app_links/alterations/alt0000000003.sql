-- Deploy: schemas/routing_public/tables/site_app_links/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_app_links/table


COMMENT ON TABLE routing_public.site_app_links IS '@scope database
@scopeKey database_id
@scopeTier database
Native-app deep-link association metadata for a site surface (feeds AASA / assetlinks.json generation)';