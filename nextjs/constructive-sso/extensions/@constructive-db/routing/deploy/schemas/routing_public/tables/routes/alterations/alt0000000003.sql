-- Deploy: schemas/routing_public/tables/routes/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/table


COMMENT ON TABLE routing_public.routes IS '@scope database
@scopeKey database_id
@scopeTier database
Routes binding a domain hostname and path to a typed catalog target';