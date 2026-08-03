-- Revert: schemas/routing_public/tables/domain_verifications/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.domain_verifications 
  ALTER COLUMN created_at DROP DEFAULT;