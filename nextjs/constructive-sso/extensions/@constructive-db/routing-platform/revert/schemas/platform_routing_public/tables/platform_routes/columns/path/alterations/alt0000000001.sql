-- Revert: schemas/platform_routing_public/tables/platform_routes/columns/path/alterations/alt0000000001


ALTER TABLE platform_routing_public.platform_routes 
  ALTER COLUMN path DROP NOT NULL;