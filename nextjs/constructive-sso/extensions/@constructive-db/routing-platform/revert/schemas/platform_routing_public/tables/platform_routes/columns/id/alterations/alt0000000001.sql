-- Revert: schemas/platform_routing_public/tables/platform_routes/columns/id/alterations/alt0000000001


ALTER TABLE platform_routing_public.platform_routes 
  ALTER COLUMN id DROP NOT NULL;