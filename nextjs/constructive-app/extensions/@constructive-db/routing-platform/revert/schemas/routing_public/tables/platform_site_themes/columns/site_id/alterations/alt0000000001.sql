-- Revert: schemas/routing_public/tables/platform_site_themes/columns/site_id/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_themes 
  ALTER COLUMN site_id DROP NOT NULL;