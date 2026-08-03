-- Revert: schemas/routing_public/tables/domains/columns/verification_status/alterations/alt0000000001


ALTER TABLE routing_public.domains 
  ALTER COLUMN verification_status DROP NOT NULL;