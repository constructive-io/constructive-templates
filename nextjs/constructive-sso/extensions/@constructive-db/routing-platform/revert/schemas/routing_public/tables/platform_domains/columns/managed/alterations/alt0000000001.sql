-- Revert: schemas/routing_public/tables/platform_domains/columns/managed/alterations/alt0000000001


ALTER TABLE routing_public.platform_domains 
  ALTER COLUMN managed DROP NOT NULL;