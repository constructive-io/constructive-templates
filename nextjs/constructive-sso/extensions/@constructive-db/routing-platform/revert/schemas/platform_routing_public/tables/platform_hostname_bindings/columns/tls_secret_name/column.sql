-- Revert: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/tls_secret_name/column


ALTER TABLE platform_routing_public.platform_hostname_bindings 
  DROP COLUMN tls_secret_name RESTRICT;