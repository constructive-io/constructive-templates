-- Revert: schemas/platform_routing_public/tables/platform_routes/columns/is_active/alterations/alt0000000002


ALTER TABLE platform_routing_public.platform_routes 
  ALTER COLUMN is_active DROP DEFAULT;