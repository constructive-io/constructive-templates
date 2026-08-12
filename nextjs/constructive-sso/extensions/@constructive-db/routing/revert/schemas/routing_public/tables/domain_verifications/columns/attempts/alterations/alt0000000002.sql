-- Revert: schemas/routing_public/tables/domain_verifications/columns/attempts/alterations/alt0000000002


ALTER TABLE routing_public.domain_verifications 
  ALTER COLUMN attempts DROP DEFAULT;