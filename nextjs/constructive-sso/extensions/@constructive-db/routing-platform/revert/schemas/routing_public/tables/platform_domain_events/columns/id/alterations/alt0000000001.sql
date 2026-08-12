-- Revert: schemas/routing_public/tables/platform_domain_events/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.platform_domain_events 
  ALTER COLUMN id DROP NOT NULL;