-- Deploy: schemas/platform_routing_public/tables/platform_routes/indexes/platform_routes_domain_id_path_method_is_active_idx
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/table
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/path/column
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/method/column
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/domain_id/column
-- requires: schemas/platform_routing_public/tables/platform_routes/columns/is_active/column


CREATE INDEX platform_routes_domain_id_path_method_is_active_idx ON platform_routing_public.platform_routes (domain_id, path, method, is_active);