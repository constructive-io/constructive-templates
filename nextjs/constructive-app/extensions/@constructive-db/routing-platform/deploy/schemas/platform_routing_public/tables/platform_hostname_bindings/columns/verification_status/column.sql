-- Deploy: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/verification_status/column
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/table


ALTER TABLE platform_routing_public.platform_hostname_bindings 
  ADD COLUMN verification_status text;