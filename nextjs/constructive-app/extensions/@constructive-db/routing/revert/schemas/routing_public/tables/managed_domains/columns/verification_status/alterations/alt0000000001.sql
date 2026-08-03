-- Revert: schemas/routing_public/tables/managed_domains/columns/verification_status/alterations/alt0000000001


ALTER TABLE routing_public.managed_domains 
  ALTER COLUMN verification_status DROP NOT NULL;