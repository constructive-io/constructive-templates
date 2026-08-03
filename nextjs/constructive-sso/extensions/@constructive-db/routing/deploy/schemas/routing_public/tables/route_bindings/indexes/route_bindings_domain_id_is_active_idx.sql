-- Deploy: schemas/routing_public/tables/route_bindings/indexes/route_bindings_domain_id_is_active_idx
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/route_bindings/table
-- requires: schemas/routing_public/tables/route_bindings/columns/domain_id/column
-- requires: schemas/routing_public/tables/route_bindings/columns/is_active/column


CREATE INDEX route_bindings_domain_id_is_active_idx ON routing_public.route_bindings (domain_id, is_active);