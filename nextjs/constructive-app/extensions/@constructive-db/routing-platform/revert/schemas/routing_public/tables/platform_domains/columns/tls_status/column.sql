-- Revert: schemas/routing_public/tables/platform_domains/columns/tls_status/column


ALTER TABLE routing_public.platform_domains 
  DROP COLUMN tls_status RESTRICT;