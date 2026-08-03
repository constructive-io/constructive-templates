-- Revert: schemas/routing_public/tables/platform_sites/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.platform_sites 
  ALTER COLUMN id DROP DEFAULT;