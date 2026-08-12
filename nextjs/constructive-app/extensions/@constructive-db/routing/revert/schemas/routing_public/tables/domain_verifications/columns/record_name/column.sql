-- Revert: schemas/routing_public/tables/domain_verifications/columns/record_name/column


ALTER TABLE routing_public.domain_verifications 
  DROP COLUMN record_name RESTRICT;