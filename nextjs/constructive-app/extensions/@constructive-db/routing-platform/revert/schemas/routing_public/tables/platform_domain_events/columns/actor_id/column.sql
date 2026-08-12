-- Revert: schemas/routing_public/tables/platform_domain_events/columns/actor_id/column


ALTER TABLE routing_public.platform_domain_events 
  DROP COLUMN actor_id RESTRICT;