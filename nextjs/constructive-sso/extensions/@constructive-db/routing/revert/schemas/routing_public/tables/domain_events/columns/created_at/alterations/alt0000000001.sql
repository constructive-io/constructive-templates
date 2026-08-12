-- Revert: schemas/routing_public/tables/domain_events/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.domain_events 
  ALTER COLUMN created_at DROP DEFAULT;