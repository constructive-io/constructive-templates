-- Revert: schemas/routing_public/tables/platform_domains/columns/verification_status/alterations/alt0000000001


ALTER TABLE routing_public.platform_domains 
  ALTER COLUMN verification_status DROP NOT NULL;