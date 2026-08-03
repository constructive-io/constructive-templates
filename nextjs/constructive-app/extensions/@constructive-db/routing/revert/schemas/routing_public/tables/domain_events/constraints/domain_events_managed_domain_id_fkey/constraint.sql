-- Revert: schemas/routing_public/tables/domain_events/constraints/domain_events_managed_domain_id_fkey/constraint


ALTER TABLE routing_public.domain_events 
  DROP CONSTRAINT domain_events_managed_domain_id_fkey RESTRICT;