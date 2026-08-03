-- Revert: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/tls_status/column


ALTER TABLE platform_routing_public.platform_hostname_bindings 
  DROP COLUMN tls_status RESTRICT;