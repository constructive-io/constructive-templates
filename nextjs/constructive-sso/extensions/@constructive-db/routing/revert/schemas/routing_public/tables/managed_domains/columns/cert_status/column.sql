-- Revert: schemas/routing_public/tables/managed_domains/columns/cert_status/column


ALTER TABLE routing_public.managed_domains 
  DROP COLUMN cert_status RESTRICT;