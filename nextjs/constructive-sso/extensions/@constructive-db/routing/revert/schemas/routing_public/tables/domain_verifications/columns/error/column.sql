-- Revert: schemas/routing_public/tables/domain_verifications/columns/error/column


ALTER TABLE routing_public.domain_verifications 
  DROP COLUMN error RESTRICT;