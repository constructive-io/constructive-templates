-- Deploy: schemas/routing_public/tables/routes/columns/is_active/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/columns/is_active/column


COMMENT ON COLUMN routing_public.routes.is_active IS 'Inactive routes are excluded from resolution';