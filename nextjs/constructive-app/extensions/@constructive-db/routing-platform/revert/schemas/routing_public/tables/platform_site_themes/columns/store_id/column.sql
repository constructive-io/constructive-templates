-- Revert: schemas/routing_public/tables/platform_site_themes/columns/store_id/column


ALTER TABLE routing_public.platform_site_themes 
  DROP COLUMN store_id RESTRICT;