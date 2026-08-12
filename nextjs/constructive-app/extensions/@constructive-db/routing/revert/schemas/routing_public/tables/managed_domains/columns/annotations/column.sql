-- Revert: schemas/routing_public/tables/managed_domains/columns/annotations/column


ALTER TABLE routing_public.managed_domains 
  DROP COLUMN annotations RESTRICT;