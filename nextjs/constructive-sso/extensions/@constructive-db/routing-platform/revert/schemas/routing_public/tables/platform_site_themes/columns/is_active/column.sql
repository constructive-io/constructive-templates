-- Revert: schemas/routing_public/tables/platform_site_themes/columns/is_active/column


ALTER TABLE routing_public.platform_site_themes 
  DROP COLUMN is_active RESTRICT;