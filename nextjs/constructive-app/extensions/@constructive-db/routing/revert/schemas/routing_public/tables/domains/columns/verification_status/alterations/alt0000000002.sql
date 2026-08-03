-- Revert: schemas/routing_public/tables/domains/columns/verification_status/alterations/alt0000000002


ALTER TABLE routing_public.domains 
  ALTER COLUMN verification_status DROP DEFAULT;