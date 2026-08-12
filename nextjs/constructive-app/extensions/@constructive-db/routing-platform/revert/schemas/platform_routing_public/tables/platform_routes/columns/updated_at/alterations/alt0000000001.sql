-- Revert: schemas/platform_routing_public/tables/platform_routes/columns/updated_at/alterations/alt0000000001


ALTER TABLE platform_routing_public.platform_routes 
  ALTER COLUMN updated_at DROP DEFAULT;