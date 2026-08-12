-- Revert: schemas/platform_routing_public/tables/platform_routes/columns/updated_at/column


ALTER TABLE platform_routing_public.platform_routes 
  DROP COLUMN updated_at RESTRICT;