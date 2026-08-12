-- Deploy: schemas/platform_routing_public/tables/platform_hostname_bindings/constraints/platform_hostname_bindings_hostname_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/table


ALTER TABLE platform_routing_public.platform_hostname_bindings 
  ADD CONSTRAINT platform_hostname_bindings_hostname_key 
    UNIQUE (hostname);