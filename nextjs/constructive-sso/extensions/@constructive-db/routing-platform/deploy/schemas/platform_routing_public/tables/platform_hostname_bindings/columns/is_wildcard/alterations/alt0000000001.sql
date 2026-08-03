-- Deploy: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/is_wildcard/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/table
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/is_wildcard/column


ALTER TABLE platform_routing_public.platform_hostname_bindings 
  ALTER COLUMN is_wildcard SET NOT NULL;