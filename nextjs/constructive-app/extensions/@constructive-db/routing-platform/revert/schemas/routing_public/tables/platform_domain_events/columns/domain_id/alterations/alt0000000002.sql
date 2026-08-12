-- Revert: schemas/routing_public/tables/platform_domain_events/columns/domain_id/alterations/alt0000000002


ALTER TABLE routing_public.platform_domain_events 
  DROP CONSTRAINT platform_domain_events_domain_id_managed_domain_id_chk RESTRICT;