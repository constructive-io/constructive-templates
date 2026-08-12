-- Revert: schemas/routing_public/tables/platform_site_themes/columns/site_id/column


ALTER TABLE routing_public.platform_site_themes 
  DROP COLUMN site_id RESTRICT;