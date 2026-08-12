-- Revert: schemas/routing_public/tables/platform_domain_events/constraints/platform_domain_events_pkey/constraint


ALTER TABLE routing_public.platform_domain_events 
  DROP CONSTRAINT platform_domain_events_pkey RESTRICT;