-- Revert: schemas/routing_public/tables/domain_verifications/columns/status/alterations/alt0000000001


ALTER TABLE routing_public.domain_verifications 
  ALTER COLUMN status DROP NOT NULL;