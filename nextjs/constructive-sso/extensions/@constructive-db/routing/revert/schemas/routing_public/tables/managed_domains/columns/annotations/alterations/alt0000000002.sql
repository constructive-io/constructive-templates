-- Revert: schemas/routing_public/tables/managed_domains/columns/annotations/alterations/alt0000000002


ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN annotations DROP DEFAULT;