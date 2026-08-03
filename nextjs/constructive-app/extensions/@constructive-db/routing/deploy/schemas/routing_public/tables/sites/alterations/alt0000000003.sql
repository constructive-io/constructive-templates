-- Deploy: schemas/routing_public/tables/sites/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/sites/table


COMMENT ON TABLE routing_public.sites IS '@scope database
@scopeKey database_id
@scopeTier database
Site surfaces exposed by this scope; publication makes a surface bindable from other scopes';