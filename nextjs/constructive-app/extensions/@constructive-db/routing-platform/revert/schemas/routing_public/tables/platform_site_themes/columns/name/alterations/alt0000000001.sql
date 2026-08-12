-- Revert: schemas/routing_public/tables/platform_site_themes/columns/name/alterations/alt0000000001


ALTER TABLE routing_public.platform_site_themes 
  ALTER COLUMN name DROP NOT NULL;