-- Revert: schemas/routing_public/tables/platform_site_themes/columns/created_at/column


ALTER TABLE routing_public.platform_site_themes 
  DROP COLUMN created_at RESTRICT;