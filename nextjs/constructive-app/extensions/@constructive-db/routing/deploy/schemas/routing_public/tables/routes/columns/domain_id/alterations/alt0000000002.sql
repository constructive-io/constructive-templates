-- Deploy: schemas/routing_public/tables/routes/columns/domain_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/columns/domain_id/column


COMMENT ON COLUMN routing_public.routes.domain_id IS 'Domain whose hostname this route serves';