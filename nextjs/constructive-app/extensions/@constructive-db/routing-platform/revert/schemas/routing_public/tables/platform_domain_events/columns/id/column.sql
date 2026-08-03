-- Revert: schemas/routing_public/tables/platform_domain_events/columns/id/column


ALTER TABLE routing_public.platform_domain_events 
  DROP COLUMN id RESTRICT;