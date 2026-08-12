-- Revert: schemas/platform_routing_public/tables/platform_routes/columns/priority/alterations/alt0000000002


ALTER TABLE platform_routing_public.platform_routes 
  ALTER COLUMN priority DROP DEFAULT;