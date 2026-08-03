-- Revert: schemas/routing_public/tables/domain_verifications/columns/updated_at/column


ALTER TABLE routing_public.domain_verifications 
  DROP COLUMN updated_at RESTRICT;