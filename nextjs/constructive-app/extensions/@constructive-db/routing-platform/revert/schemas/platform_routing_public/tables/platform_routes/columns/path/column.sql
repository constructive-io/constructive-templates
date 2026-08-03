-- Revert: schemas/platform_routing_public/tables/platform_routes/columns/path/column


ALTER TABLE platform_routing_public.platform_routes 
  DROP COLUMN path RESTRICT;