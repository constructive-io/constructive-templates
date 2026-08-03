-- Revert: schemas/routing_public/tables/domains/columns/managed/column


ALTER TABLE routing_public.domains 
  DROP COLUMN managed RESTRICT;