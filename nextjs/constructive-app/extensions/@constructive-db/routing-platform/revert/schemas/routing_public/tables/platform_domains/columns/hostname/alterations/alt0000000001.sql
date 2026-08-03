-- Revert: schemas/routing_public/tables/platform_domains/columns/hostname/alterations/alt0000000001


ALTER TABLE routing_public.platform_domains 
  ALTER COLUMN hostname DROP NOT NULL;