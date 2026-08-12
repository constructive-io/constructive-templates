-- Revert: schemas/routing_public/tables/domains/columns/is_wildcard/column


ALTER TABLE routing_public.domains 
  DROP COLUMN is_wildcard RESTRICT;