-- Revert: schemas/routing_public/tables/hostname_bindings/columns/hostname/column


ALTER TABLE routing_public.hostname_bindings 
  DROP COLUMN hostname RESTRICT;