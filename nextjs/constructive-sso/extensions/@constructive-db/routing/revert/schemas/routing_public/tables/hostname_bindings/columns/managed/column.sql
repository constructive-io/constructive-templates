-- Revert: schemas/routing_public/tables/hostname_bindings/columns/managed/column


ALTER TABLE routing_public.hostname_bindings 
  DROP COLUMN managed RESTRICT;