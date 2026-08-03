-- Revert: schemas/routing_public/tables/domain_events/columns/message/column


ALTER TABLE routing_public.domain_events 
  DROP COLUMN message RESTRICT;