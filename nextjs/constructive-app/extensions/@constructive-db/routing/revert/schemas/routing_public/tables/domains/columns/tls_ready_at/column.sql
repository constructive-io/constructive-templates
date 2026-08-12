-- Revert: schemas/routing_public/tables/domains/columns/tls_ready_at/column


ALTER TABLE routing_public.domains 
  DROP COLUMN tls_ready_at RESTRICT;