-- Revert: schemas/routing_public/tables/domain_events/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.domain_events 
  ALTER COLUMN id DROP DEFAULT;