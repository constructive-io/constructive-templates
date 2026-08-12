-- Revert: schemas/routing_public/tables/hostname_bindings/columns/is_wildcard/column


ALTER TABLE routing_public.hostname_bindings 
  DROP COLUMN is_wildcard RESTRICT;