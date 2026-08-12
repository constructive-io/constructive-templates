-- Revert: schemas/routing_public/tables/hostname_bindings/columns/updated_at/alterations/alt0000000001


ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN updated_at DROP NOT NULL;