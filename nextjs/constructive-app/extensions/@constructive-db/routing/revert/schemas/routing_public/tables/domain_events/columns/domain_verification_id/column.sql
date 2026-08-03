-- Revert: schemas/routing_public/tables/domain_events/columns/domain_verification_id/column


ALTER TABLE routing_public.domain_events 
  DROP COLUMN domain_verification_id RESTRICT;