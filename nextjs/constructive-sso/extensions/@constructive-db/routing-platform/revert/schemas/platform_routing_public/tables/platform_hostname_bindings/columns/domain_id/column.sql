-- Revert: schemas/platform_routing_public/tables/platform_hostname_bindings/columns/domain_id/column


ALTER TABLE platform_routing_public.platform_hostname_bindings 
  DROP COLUMN domain_id RESTRICT;