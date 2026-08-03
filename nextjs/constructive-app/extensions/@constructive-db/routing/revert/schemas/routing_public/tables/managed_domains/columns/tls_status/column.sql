-- Revert: schemas/routing_public/tables/managed_domains/columns/tls_status/column


ALTER TABLE routing_public.managed_domains 
  DROP COLUMN tls_status RESTRICT;