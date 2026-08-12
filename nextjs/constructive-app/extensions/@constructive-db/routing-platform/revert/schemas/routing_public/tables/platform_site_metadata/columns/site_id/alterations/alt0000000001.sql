-- Revert: schemas/routing_public/tables/platform_site_metadata/columns/site_id/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_metadata 
  ALTER COLUMN site_id DROP NOT NULL;