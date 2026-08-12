-- Revert: schemas/routing_public/tables/platform_site_themes/columns/name/column


ALTER TABLE routing_public.platform_site_themes 
  DROP COLUMN name RESTRICT;