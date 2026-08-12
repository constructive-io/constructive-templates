-- Revert: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/hostname/alterations/alt0000000001


ALTER TABLE platform_routing_public.platform_hostname_bindings 
  ALTER COLUMN hostname DROP NOT NULL;