-- Revert: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/is_wildcard/column


ALTER TABLE platform_routing_public.platform_hostname_bindings 
  DROP COLUMN is_wildcard RESTRICT;