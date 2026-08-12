-- Revert: schemas/routing_public/tables/platform_domain_verifications/columns/attempts/alterations/alt0000000001


ALTER TABLE routing_public.platform_domain_verifications 
  ALTER COLUMN attempts DROP NOT NULL;