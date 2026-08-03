-- Revert: schemas/routing_public/tables/domain_verifications/columns/record_type/column


ALTER TABLE routing_public.domain_verifications 
  DROP COLUMN record_type RESTRICT;