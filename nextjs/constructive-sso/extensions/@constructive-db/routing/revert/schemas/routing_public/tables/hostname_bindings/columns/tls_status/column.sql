-- Revert: schemas/routing_public/tables/hostname_bindings/columns/tls_status/column


ALTER TABLE routing_public.hostname_bindings 
  DROP COLUMN tls_status RESTRICT;