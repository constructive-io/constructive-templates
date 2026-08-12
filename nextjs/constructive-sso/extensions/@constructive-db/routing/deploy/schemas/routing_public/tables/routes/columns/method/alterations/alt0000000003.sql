-- Deploy: schemas/routing_public/tables/routes/columns/method/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/columns/method/column


COMMENT ON COLUMN routing_public.routes.method IS '@has_guard
Uppercase HTTP method this route matches; NULL matches any method';