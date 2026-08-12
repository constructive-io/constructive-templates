-- Revert: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/updated_at/column


ALTER TABLE platform_routing_public.platform_hostname_bindings 
  DROP COLUMN updated_at RESTRICT;