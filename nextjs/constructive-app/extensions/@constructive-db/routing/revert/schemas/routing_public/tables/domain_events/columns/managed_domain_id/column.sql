-- Revert: schemas/routing_public/tables/domain_events/columns/managed_domain_id/column


ALTER TABLE routing_public.domain_events 
  DROP COLUMN managed_domain_id RESTRICT;