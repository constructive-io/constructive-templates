-- Revert: schemas/platform_routing_public/tables/platform_route_bindings/columns/updated_at/alterations/alt0000000001


ALTER TABLE platform_routing_public.platform_route_bindings 
  ALTER COLUMN updated_at DROP NOT NULL;