-- Revert: schemas/routing_public/tables/managed_domains/columns/id/alterations/alt0000000001


ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN id DROP NOT NULL;