-- Revert: schemas/platform_routing_public/tables/platform_routes/columns/created_at/alterations/alt0000000001


ALTER TABLE platform_routing_public.platform_routes 
  ALTER COLUMN created_at DROP DEFAULT;