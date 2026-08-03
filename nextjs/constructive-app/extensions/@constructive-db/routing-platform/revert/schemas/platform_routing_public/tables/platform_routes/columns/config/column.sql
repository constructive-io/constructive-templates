-- Revert: schemas/platform_routing_public/tables/platform_routes/columns/config/column


ALTER TABLE platform_routing_public.platform_routes 
  DROP COLUMN config RESTRICT;