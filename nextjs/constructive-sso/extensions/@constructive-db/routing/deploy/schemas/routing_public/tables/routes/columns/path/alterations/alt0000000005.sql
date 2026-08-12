-- Deploy: schemas/routing_public/tables/routes/columns/path/alterations/alt0000000005
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/columns/path/column


COMMENT ON COLUMN routing_public.routes.path IS '@has_guard
Path prefix this route matches; must begin with / and carry no trailing slash';