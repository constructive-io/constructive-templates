-- Revert: schemas/routing_public/tables/domain_verifications/columns/status/column


ALTER TABLE routing_public.domain_verifications 
  DROP COLUMN status RESTRICT;