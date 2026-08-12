-- Revert: schemas/routing_public/tables/hostname_bindings/constraints/hostname_bindings_pkey/constraint


ALTER TABLE routing_public.hostname_bindings 
  DROP CONSTRAINT hostname_bindings_pkey RESTRICT;