-- Revert: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/managed/column


ALTER TABLE platform_routing_public.platform_hostname_bindings 
  DROP COLUMN managed RESTRICT;