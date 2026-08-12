-- Deploy: schemas/routing_public/tables/domain_events/columns/event_type/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/domain_events/table
-- requires: schemas/routing_public/tables/domain_events/columns/event_type/column


ALTER TABLE routing_public.domain_events 
  ALTER COLUMN event_type SET NOT NULL;