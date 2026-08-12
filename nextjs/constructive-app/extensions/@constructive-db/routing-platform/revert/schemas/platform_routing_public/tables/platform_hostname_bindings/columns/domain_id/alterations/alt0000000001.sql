-- Revert: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/domain_id/alterations/alt0000000001


ALTER TABLE platform_routing_public.platform_hostname_bindings 
  ALTER COLUMN domain_id DROP NOT NULL;