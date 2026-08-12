-- Revert: schemas/routing_public/tables/domain_events/columns/domain_id/column


ALTER TABLE routing_public.domain_events 
  DROP COLUMN domain_id RESTRICT;