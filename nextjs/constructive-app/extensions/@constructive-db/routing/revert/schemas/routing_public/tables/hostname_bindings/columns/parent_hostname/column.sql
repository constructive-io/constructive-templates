-- Revert: schemas/routing_public/tables/hostname_bindings/columns/parent_hostname/column


ALTER TABLE routing_public.hostname_bindings 
  DROP COLUMN parent_hostname RESTRICT;