-- Revert: schemas/routing_public/tables/hostname_bindings/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN id DROP DEFAULT;