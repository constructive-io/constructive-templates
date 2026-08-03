-- Deploy: schemas/routing_public/tables/http_routes/columns/target_id/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/columns/target_id/column


COMMENT ON COLUMN routing_public.http_routes.target_id IS 'Target row of the type named by target_kind; existence enforced by trigger';