-- Revert: schemas/routing_public/tables/domain_events/columns/database_id/column


ALTER TABLE routing_public.domain_events 
  DROP COLUMN database_id RESTRICT;