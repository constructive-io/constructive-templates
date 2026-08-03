-- Revert: schemas/routing_public/tables/platform_domain_events/columns/created_at/column


ALTER TABLE routing_public.platform_domain_events 
  DROP COLUMN created_at RESTRICT;