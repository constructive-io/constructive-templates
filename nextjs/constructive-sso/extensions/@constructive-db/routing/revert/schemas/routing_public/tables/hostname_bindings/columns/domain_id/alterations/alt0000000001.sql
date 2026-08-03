-- Revert: schemas/routing_public/tables/hostname_bindings/columns/domain_id/alterations/alt0000000001


ALTER TABLE routing_public.hostname_bindings 
  ALTER COLUMN domain_id DROP NOT NULL;