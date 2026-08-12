-- Revert: schemas/routing_public/tables/managed_domains/columns/cert_status/alterations/alt0000000002


ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN cert_status DROP DEFAULT;