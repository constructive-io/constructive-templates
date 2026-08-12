-- Revert: schemas/routing_public/tables/platform_pages/columns/id/alterations/alt0000000002


ALTER TABLE routing_public.platform_pages 
  ALTER COLUMN id DROP DEFAULT;