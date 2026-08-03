-- Revert: schemas/routing_public/tables/platform_managed_domains/columns/cert_status/alterations/alt0000000001


ALTER TABLE routing_public.platform_managed_domains 
  ALTER COLUMN cert_status DROP NOT NULL;