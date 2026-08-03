-- Deploy: schemas/routing_public/tables/site_modules/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_modules/table


COMMENT ON TABLE routing_public.site_modules IS '@scope database
@scopeKey database_id
@scopeTier database
Frontend module configuration for a site surface; stores module name and JSON settings';