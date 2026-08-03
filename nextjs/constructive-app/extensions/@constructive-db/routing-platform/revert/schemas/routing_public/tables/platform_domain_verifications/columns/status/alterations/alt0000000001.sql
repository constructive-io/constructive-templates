-- Revert: schemas/routing_public/tables/platform_domain_verifications/columns/status/alterations/alt0000000001


ALTER TABLE routing_public.platform_domain_verifications 
  ALTER COLUMN status DROP NOT NULL;