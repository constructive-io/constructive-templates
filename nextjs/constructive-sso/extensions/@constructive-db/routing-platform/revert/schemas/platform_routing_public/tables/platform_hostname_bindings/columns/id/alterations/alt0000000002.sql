-- Revert: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/id/alterations/alt0000000002


ALTER TABLE platform_routing_public.platform_hostname_bindings 
  ALTER COLUMN id DROP DEFAULT;