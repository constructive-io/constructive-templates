-- Revert: schemas/routing_public/tables/hostname_bindings/columns/hostname/alterations/alt0000000001


ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN hostname DROP NOT NULL;