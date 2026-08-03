-- Revert: schemas/platform_routing_public/tables/platform_routes/columns/priority/column


ALTER TABLE platform_routing_public.platform_routes 
  DROP COLUMN priority RESTRICT;