-- Revert: schemas/routing_public/tables/domain_verifications/columns/last_checked_at/column


ALTER TABLE routing_public.domain_verifications 
  DROP COLUMN last_checked_at RESTRICT;