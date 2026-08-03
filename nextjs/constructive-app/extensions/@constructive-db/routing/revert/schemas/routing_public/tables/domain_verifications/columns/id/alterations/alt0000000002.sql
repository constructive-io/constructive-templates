-- Revert: schemas/routing_public/tables/domain_verifications/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.domain_verifications 
  ALTER COLUMN id DROP DEFAULT;