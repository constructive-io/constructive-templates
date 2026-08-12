-- Revert: schemas/routing_public/tables/platform_domain_events/columns/created_at/alterations/alt0000000001


ALTER TABLE routing_public.platform_domain_events 
  ALTER COLUMN created_at DROP DEFAULT;