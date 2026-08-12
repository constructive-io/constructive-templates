-- Revert: schemas/routing_public/tables/hostname_bindings/columns/domain_id/column


ALTER TABLE routing_public.hostname_bindings 
  DROP COLUMN domain_id RESTRICT;