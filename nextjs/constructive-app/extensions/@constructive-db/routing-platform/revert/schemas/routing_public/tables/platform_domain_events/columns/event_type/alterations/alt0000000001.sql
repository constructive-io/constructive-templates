-- Revert: schemas/routing_public/tables/platform_domain_events/columns/event_type/alterations/alt0000000001


ALTER TABLE routing_public.platform_domain_events 
  ALTER COLUMN event_type DROP NOT NULL;