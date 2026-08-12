-- Deploy: schemas/routing_public/tables/routes/columns/config/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/columns/config/column


COMMENT ON COLUMN routing_public.routes.config IS 'Route metadata; target configuration is read live from the typed catalog, never copied here';