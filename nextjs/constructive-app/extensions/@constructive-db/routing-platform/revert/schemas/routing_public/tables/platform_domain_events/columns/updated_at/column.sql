-- Revert: schemas/routing_public/tables/platform_domain_events/columns/updated_at/column


ALTER TABLE routing_public.platform_domain_events 
  DROP COLUMN updated_at RESTRICT;