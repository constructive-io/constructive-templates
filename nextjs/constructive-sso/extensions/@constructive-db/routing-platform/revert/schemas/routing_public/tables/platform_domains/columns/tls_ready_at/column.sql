-- Revert: schemas/routing_public/tables/platform_domains/columns/tls_ready_at/column


ALTER TABLE routing_public.platform_domains 
  DROP COLUMN tls_ready_at RESTRICT;