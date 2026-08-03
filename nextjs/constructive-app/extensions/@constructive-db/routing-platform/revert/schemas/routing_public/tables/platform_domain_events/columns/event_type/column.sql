-- Revert: schemas/routing_public/tables/platform_domain_events/columns/event_type/column


ALTER TABLE routing_public.platform_domain_events 
  DROP COLUMN event_type RESTRICT;