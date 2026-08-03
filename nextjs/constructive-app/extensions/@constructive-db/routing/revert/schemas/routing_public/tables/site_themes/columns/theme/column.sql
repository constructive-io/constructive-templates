-- Revert: schemas/routing_public/tables/site_themes/columns/theme/column


ALTER TABLE routing_public.site_themes 
  DROP COLUMN theme RESTRICT;