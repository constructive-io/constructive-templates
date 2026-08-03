-- Revert: schemas/routing_public/tables/domain_events/columns/event_type/column


ALTER TABLE routing_public.domain_events 
  DROP COLUMN event_type RESTRICT;