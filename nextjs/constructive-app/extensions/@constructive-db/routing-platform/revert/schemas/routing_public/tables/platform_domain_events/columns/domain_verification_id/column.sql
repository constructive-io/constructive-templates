-- Revert: schemas/routing_public/tables/platform_domain_events/columns/domain_verification_id/column


ALTER TABLE routing_public.platform_domain_events 
  DROP COLUMN domain_verification_id RESTRICT;