-- Revert: schemas/routing_public/tables/hostname_bindings/columns/updated_at/column


ALTER TABLE routing_public.hostname_bindings 
  DROP COLUMN updated_at RESTRICT;