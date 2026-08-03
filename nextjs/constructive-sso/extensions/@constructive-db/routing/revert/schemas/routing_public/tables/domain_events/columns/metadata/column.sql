-- Revert: schemas/routing_public/tables/domain_events/columns/metadata/column


ALTER TABLE routing_public.domain_events 
  DROP COLUMN metadata RESTRICT;