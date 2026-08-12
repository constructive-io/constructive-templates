-- Revert: schemas/platform_routing_public/tables/platform_routes/columns/created_at/column


ALTER TABLE platform_routing_public.platform_routes 
  DROP COLUMN created_at RESTRICT;