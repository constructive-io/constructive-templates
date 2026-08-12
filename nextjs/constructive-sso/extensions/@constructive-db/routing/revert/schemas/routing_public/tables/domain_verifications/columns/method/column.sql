-- Revert: schemas/routing_public/tables/domain_verifications/columns/method/column


ALTER TABLE routing_public.domain_verifications 
  DROP COLUMN method RESTRICT;