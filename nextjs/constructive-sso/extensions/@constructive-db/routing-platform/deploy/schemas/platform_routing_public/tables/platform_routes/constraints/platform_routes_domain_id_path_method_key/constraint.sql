-- Deploy: schemas/platform_routing_public/tables/platform_routes/constraints/platform_routes_domain_id_path_method_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_routes/table


ALTER TABLE platform_routing_public.platform_routes 
  ADD CONSTRAINT platform_routes_domain_id_path_method_key 
    UNIQUE (domain_id, path, method);