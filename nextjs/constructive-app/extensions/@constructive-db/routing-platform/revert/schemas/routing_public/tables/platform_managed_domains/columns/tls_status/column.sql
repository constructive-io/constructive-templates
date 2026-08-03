-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/tls_status/column


ALTER TABLE routing_public.platform_managed_domains 
  DROP COLUMN tls_status RESTRICT;