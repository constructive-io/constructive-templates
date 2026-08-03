-- Deploy: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/updated_at/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/platform_routing_public/schema
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/table
-- requires: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/updated_at/column


ALTER TABLE platform_routing_public.platform_hostname_bindings 
  ALTER COLUMN updated_at SET DEFAULT now();