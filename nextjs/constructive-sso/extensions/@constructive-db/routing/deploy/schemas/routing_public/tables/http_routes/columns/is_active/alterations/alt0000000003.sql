-- Deploy: schemas/routing_public/tables/http_routes/columns/is_active/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/columns/is_active/column


COMMENT ON COLUMN routing_public.http_routes.is_active IS 'Whether the resolver may select this route';