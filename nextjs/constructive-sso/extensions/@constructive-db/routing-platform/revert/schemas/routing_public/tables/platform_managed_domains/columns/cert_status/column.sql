-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/cert_status/column


ALTER TABLE routing_public.platform_managed_domains 
  DROP COLUMN cert_status RESTRICT;