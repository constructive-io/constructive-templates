-- Revert: schemas/routing_public/tables/hostname_bindings/columns/verification_status/column


ALTER TABLE routing_public.hostname_bindings 
  DROP COLUMN verification_status RESTRICT;