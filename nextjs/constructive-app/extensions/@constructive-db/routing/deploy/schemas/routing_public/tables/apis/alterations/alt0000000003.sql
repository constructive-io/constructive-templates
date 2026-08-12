-- Deploy: schemas/routing_public/tables/apis/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/apis/table


COMMENT ON TABLE routing_public.apis IS '@scope database
@scopeKey database_id
@scopeTier database
API surfaces exposed by this scope; publication makes a surface bindable from other scopes';