-- Revert: schemas/routing_public/tables/managed_domains/columns/verification_status/column


ALTER TABLE routing_public.managed_domains 
  DROP COLUMN verification_status RESTRICT;