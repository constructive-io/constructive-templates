-- Revert: schemas/routing_public/tables/platform_domain_verifications/columns/method/alterations/alt0000000001


ALTER TABLE routing_public.platform_domain_verifications 
  ALTER COLUMN method DROP NOT NULL;