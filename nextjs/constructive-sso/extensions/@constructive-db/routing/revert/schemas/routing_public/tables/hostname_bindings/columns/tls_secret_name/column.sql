-- Revert: schemas/routing_public/tables/hostname_bindings/columns/tls_secret_name/column


ALTER TABLE routing_public.hostname_bindings 
  DROP COLUMN tls_secret_name RESTRICT;