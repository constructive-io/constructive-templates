-- Revert: schemas/platform_routing_public/tables/platform_routes/columns/is_active/column


ALTER TABLE platform_routing_public.platform_routes 
  DROP COLUMN is_active RESTRICT;