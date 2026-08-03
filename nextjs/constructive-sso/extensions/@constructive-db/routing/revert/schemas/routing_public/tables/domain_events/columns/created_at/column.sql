-- Revert: schemas/routing_public/tables/domain_events/columns/created_at/column


ALTER TABLE routing_public.domain_events 
  DROP COLUMN created_at RESTRICT;