-- Revert: schemas/routing_public/tables/platform_domain_events/columns/managed_domain_id/column


ALTER TABLE routing_public.platform_domain_events 
  DROP COLUMN managed_domain_id RESTRICT;