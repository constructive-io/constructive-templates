-- Revert: schemas/routing_public/tables/platform_site_themes/constraints/platform_site_themes_site_id_name_key/constraint


ALTER TABLE routing_public.platform_site_themes 
  DROP CONSTRAINT platform_site_themes_site_id_name_key RESTRICT;