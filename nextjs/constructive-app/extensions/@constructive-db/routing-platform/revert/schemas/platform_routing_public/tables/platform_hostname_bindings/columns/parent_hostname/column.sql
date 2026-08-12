-- Revert: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/parent_hostname/column


ALTER TABLE platform_routing_public.platform_hostname_bindings 
  DROP COLUMN parent_hostname RESTRICT;