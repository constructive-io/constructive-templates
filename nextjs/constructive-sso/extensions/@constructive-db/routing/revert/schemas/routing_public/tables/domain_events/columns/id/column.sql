-- Revert: schemas/routing_public/tables/domain_events/columns/id/column


ALTER TABLE routing_public.domain_events 
  DROP COLUMN id RESTRICT;