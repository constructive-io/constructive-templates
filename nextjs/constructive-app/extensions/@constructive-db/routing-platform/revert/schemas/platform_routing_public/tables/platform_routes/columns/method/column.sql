-- Revert: schemas/platform_routing_public/tables/platform_routes/columns/method/column


ALTER TABLE platform_routing_public.platform_routes 
  DROP COLUMN method RESTRICT;