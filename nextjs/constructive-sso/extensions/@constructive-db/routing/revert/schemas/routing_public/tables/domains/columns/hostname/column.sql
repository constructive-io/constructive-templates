-- Revert: schemas/routing_public/tables/domains/columns/hostname/column


ALTER TABLE routing_public.domains 
  DROP COLUMN hostname RESTRICT;