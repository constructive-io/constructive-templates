-- Revert: schemas/routing_public/tables/domains/columns/verification_status/column


ALTER TABLE routing_public.domains 
  DROP COLUMN verification_status RESTRICT;