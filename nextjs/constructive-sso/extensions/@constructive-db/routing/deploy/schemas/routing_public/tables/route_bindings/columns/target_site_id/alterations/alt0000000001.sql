-- Deploy: schemas/routing_public/tables/route_bindings/columns/target_site_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/route_bindings/columns/target_site_id/column


COMMENT ON COLUMN routing_public.route_bindings.target_site_id IS 'Site catalog row the source route targets';