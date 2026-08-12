-- Deploy: schemas/routing_public/tables/routes/columns/target_function_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/columns/target_function_id/column


COMMENT ON COLUMN routing_public.routes.target_function_id IS 'Function catalog row this route targets; must be owner-matched or visible cross-scope';