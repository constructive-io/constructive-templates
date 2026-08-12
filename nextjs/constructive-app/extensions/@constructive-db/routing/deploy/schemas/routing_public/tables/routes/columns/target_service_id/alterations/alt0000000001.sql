-- Deploy: schemas/routing_public/tables/routes/columns/target_service_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/columns/target_service_id/column


COMMENT ON COLUMN routing_public.routes.target_service_id IS 'Resource catalog row (a Service resource) this route targets; must be owner-matched or visible cross-scope';