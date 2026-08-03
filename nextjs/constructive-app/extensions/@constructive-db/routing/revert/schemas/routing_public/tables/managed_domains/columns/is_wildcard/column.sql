-- Revert: schemas/routing_public/tables/managed_domains/columns/is_wildcard/column


ALTER TABLE routing_public.managed_domains 
  DROP COLUMN is_wildcard RESTRICT;