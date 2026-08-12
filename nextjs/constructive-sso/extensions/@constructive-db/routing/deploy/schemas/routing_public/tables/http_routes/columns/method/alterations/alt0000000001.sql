-- Deploy: schemas/routing_public/tables/http_routes/columns/method/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/columns/method/column


COMMENT ON COLUMN routing_public.http_routes.method IS 'Optional uppercase HTTP method; NULL matches every method';