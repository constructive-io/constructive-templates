-- Revert: schemas/routing_public/tables/domain_verifications/columns/method/alterations/alt0000000001


ALTER TABLE routing_public.domain_verifications 
  ALTER COLUMN method DROP NOT NULL;