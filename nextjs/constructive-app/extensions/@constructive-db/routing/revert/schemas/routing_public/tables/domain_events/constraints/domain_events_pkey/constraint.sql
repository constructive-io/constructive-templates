-- Revert: schemas/routing_public/tables/domain_events/constraints/domain_events_pkey/constraint


ALTER TABLE routing_public.domain_events 
  DROP CONSTRAINT domain_events_pkey RESTRICT;