-- Revert: schemas/routing_public/tables/managed_domains/columns/annotations/alterations/alt0000000001


ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN annotations DROP NOT NULL;