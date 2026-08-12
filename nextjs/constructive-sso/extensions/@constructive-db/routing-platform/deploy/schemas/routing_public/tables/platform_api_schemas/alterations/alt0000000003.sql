-- Deploy: schemas/routing_public/tables/platform_api_schemas/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_api_schemas/table


COMMENT ON TABLE routing_public.platform_api_schemas IS '@scope platform
@scopeTier global
Join table linking API surfaces to the metaschema schemas they expose';