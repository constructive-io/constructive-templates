-- Revert: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/managed/alterations/alt0000000001


ALTER TABLE platform_routing_public.platform_hostname_bindings 
  ALTER COLUMN managed DROP NOT NULL;