-- Deploy: schemas/routing_public/tables/http_routes/columns/path/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/columns/path/column


COMMENT ON COLUMN routing_public.http_routes.path IS 'Normalized request path prefix; longest matching prefix wins';