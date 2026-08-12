-- Revert: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/updated_at/alterations/alt0000000002


ALTER TABLE platform_routing_public.platform_hostname_bindings 
  ALTER COLUMN updated_at DROP DEFAULT;