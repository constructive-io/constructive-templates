-- Deploy: schemas/routing_public/tables/http_routes/columns/priority/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/columns/priority/column


COMMENT ON COLUMN routing_public.http_routes.priority IS 'Tie-break precedence after path length and method specificity';