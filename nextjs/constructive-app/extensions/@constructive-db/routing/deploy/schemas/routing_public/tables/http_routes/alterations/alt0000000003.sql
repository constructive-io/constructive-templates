-- Deploy: schemas/routing_public/tables/http_routes/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/table


COMMENT ON TABLE routing_public.http_routes IS '@scope database
@scopeKey database_id
@scopeTier database
Request-time HTTP routing authority: registered domain plus path prefix and optional method to a typed target';