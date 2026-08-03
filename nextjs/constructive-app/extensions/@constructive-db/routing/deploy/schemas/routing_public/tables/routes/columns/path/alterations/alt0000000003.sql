-- Deploy: schemas/routing_public/tables/routes/columns/path/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/columns/path/column


COMMENT ON COLUMN routing_public.routes.path IS 'Path prefix this route matches; must begin with / and carry no trailing slash';