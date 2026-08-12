-- Revert: schemas/routing_public/tables/platform_site_themes/columns/updated_at/column


ALTER TABLE routing_public.platform_site_themes 
  DROP COLUMN updated_at RESTRICT;