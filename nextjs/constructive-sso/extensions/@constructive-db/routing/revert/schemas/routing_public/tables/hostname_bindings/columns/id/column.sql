-- Revert: schemas/routing_public/tables/hostname_bindings/columns/id/column


ALTER TABLE routing_public.hostname_bindings 
  DROP COLUMN id RESTRICT;