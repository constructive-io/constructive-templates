-- Revert: schemas/routing_public/tables/hostname_bindings/columns/managed/alterations/alt0000000001


ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN managed DROP NOT NULL;