-- Deploy: schemas/routing_public/tables/routes/indexes/routes_domain_id_path_method_is_active_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/table
-- requires: schemas/routing_public/tables/routes/columns/path/column
-- requires: schemas/routing_public/tables/routes/columns/method/column
-- requires: schemas/routing_public/tables/routes/columns/domain_id/column
-- requires: schemas/routing_public/tables/routes/columns/is_active/column


CREATE INDEX routes_domain_id_path_method_is_active_idx ON routing_public.routes (domain_id, path, method, is_active);