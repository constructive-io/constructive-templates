-- Deploy: schemas/routing_public/tables/http_routes/indexes/http_routes_domain_id_path_method_is_active_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/table
-- requires: schemas/routing_public/tables/http_routes/columns/path/column
-- requires: schemas/routing_public/tables/http_routes/columns/method/column
-- requires: schemas/routing_public/tables/http_routes/columns/domain_id/column
-- requires: schemas/routing_public/tables/http_routes/columns/is_active/column


CREATE INDEX http_routes_domain_id_path_method_is_active_idx ON routing_public.http_routes (domain_id, path, method, is_active);