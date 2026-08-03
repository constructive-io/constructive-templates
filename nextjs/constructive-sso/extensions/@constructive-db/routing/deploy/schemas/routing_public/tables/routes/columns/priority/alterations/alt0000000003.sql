-- Deploy: schemas/routing_public/tables/routes/columns/priority/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/columns/priority/column


COMMENT ON COLUMN routing_public.routes.priority IS 'Higher priority wins between otherwise-equal matches';