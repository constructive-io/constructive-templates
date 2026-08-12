-- Revert: schemas/routing_public/tables/platform_site_themes/columns/id/column


ALTER TABLE routing_public.platform_site_themes 
  DROP COLUMN id RESTRICT;