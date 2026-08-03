-- Revert: schemas/routing_public/tables/domain_events/columns/actor_id/column


ALTER TABLE routing_public.domain_events 
  DROP COLUMN actor_id RESTRICT;