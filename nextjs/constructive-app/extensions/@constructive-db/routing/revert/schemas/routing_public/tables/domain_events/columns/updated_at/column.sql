-- Revert: schemas/routing_public/tables/domain_events/columns/updated_at/column


ALTER TABLE routing_public.domain_events 
  DROP COLUMN updated_at RESTRICT;