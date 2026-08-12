-- Revert: schemas/platform_routing_public/tables/platform_route_bindings/columns/domain_id/alterations/alt0000000001


ALTER TABLE platform_routing_public.platform_route_bindings 
  ALTER COLUMN domain_id DROP NOT NULL;