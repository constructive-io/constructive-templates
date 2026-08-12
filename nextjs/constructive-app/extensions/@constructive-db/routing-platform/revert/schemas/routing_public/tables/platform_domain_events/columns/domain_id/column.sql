-- Revert: schemas/routing_public/tables/platform_domain_events/columns/domain_id/column


ALTER TABLE routing_public.platform_domain_events 
  DROP COLUMN domain_id RESTRICT;