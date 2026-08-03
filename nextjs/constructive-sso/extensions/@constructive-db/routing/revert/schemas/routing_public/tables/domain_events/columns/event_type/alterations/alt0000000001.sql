-- Revert: schemas/routing_public/tables/domain_events/columns/event_type/alterations/alt0000000001


ALTER TABLE routing_public.domain_events 
  ALTER COLUMN event_type DROP NOT NULL;