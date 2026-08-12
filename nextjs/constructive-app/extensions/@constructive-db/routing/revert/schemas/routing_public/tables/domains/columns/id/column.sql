-- Revert: schemas/routing_public/tables/domains/columns/id/column


ALTER TABLE routing_public.domains 
  DROP COLUMN id RESTRICT;