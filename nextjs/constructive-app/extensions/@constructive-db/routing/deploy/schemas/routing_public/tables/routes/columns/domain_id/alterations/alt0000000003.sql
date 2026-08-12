-- Deploy: schemas/routing_public/tables/routes/columns/domain_id/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/columns/domain_id/column


COMMENT ON COLUMN routing_public.routes.domain_id IS '@has_guard
Domain whose hostname this route serves';