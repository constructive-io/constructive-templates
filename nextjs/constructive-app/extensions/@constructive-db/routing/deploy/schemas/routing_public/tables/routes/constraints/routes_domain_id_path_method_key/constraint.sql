-- Deploy: schemas/routing_public/tables/routes/constraints/routes_domain_id_path_method_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/table


ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_domain_id_path_method_key 
    UNIQUE (domain_id, path, method);