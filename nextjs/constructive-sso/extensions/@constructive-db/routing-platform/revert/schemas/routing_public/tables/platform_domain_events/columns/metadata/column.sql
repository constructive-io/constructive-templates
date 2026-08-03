-- Revert: schemas/routing_public/tables/platform_domain_events/columns/metadata/column


ALTER TABLE routing_public.platform_domain_events 
  DROP COLUMN metadata RESTRICT;