-- Revert: schemas/routing_public/tables/domains/columns/is_published/column


ALTER TABLE routing_public.domains 
  DROP COLUMN is_published RESTRICT;