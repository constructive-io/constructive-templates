-- Revert: schemas/routing_public/tables/hostname_bindings/columns/is_wildcard/alterations/alt0000000001


ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN is_wildcard DROP NOT NULL;