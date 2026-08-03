-- Revert: schemas/routing_public/tables/domain_verifications/columns/database_id/column


ALTER TABLE routing_public.domain_verifications 
  DROP COLUMN database_id RESTRICT;