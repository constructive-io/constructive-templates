-- Deploy: schemas/routing_public/tables/api_schemas/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/api_schemas/table


COMMENT ON TABLE routing_public.api_schemas IS '@scope database
@scopeKey database_id
@scopeTier database
Join table linking API surfaces to the metaschema schemas they expose';