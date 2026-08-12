-- Revert: schemas/routing_public/tables/managed_domains/columns/tls_ready_at/column


ALTER TABLE routing_public.managed_domains 
  DROP COLUMN tls_ready_at RESTRICT;