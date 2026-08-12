-- Revert: schemas/routing_public/tables/domain_events/columns/database_id/alterations/alt0000000001


ALTER TABLE routing_public.domain_events 
  ALTER COLUMN database_id DROP NOT NULL;