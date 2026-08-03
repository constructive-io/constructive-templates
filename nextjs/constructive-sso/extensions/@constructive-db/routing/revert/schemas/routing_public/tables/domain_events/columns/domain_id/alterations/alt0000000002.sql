-- Revert: schemas/routing_public/tables/domain_events/columns/domain_id/alterations/alt0000000002


ALTER TABLE routing_public.domain_events 
  DROP CONSTRAINT domain_events_domain_id_managed_domain_id_chk RESTRICT;