-- Revert: schemas/routing_public/tables/platform_pages/columns/site_id/alterations/alt0000000001


ALTER TABLE routing_public.platform_pages 
  ALTER COLUMN site_id DROP NOT NULL;