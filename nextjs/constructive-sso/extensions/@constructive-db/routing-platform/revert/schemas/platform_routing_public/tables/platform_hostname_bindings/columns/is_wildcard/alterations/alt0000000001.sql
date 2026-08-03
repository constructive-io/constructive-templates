-- Revert: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/is_wildcard/alterations/alt0000000001


ALTER TABLE platform_routing_public.platform_hostname_bindings 
  ALTER COLUMN is_wildcard DROP NOT NULL;