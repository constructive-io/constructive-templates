-- Revert: schemas/routing_public/tables/platform_pages/columns/created_at/alterations/alt0000000002


ALTER TABLE routing_public.platform_pages 
  ALTER COLUMN created_at DROP DEFAULT;