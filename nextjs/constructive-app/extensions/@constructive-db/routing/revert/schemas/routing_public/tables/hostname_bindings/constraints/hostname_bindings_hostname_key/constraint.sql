-- Revert: schemas/routing_public/tables/hostname_bindings/constraints/hostname_bindings_hostname_key/constraint


ALTER TABLE routing_public.hostname_bindings 
  DROP CONSTRAINT hostname_bindings_hostname_key RESTRICT;