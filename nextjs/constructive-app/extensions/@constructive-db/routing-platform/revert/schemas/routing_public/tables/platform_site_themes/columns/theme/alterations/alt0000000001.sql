-- Revert: schemas/routing_public/tables/platform_site_themes/columns/theme/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_themes 
  ALTER COLUMN theme DROP NOT NULL;