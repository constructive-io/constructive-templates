-- Revert: schemas/routing_public/tables/platform_domains/columns/tls_status/alterations/alt0000000002


ALTER TABLE routing_public.platform_domains 
  ALTER COLUMN tls_status DROP DEFAULT;