-- Revert: schemas/routing_public/tables/domain_verifications/columns/id/column


ALTER TABLE routing_public.domain_verifications 
  DROP COLUMN id RESTRICT;