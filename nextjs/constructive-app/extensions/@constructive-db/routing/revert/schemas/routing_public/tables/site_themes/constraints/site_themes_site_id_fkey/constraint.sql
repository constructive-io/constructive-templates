-- Revert: schemas/routing_public/tables/site_themes/constraints/site_themes_site_id_fkey/constraint


ALTER TABLE routing_public.site_themes 
  DROP CONSTRAINT site_themes_site_id_fkey RESTRICT;