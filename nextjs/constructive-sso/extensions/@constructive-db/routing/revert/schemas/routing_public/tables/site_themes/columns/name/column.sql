-- Revert: schemas/routing_public/tables/site_themes/columns/name/column


ALTER TABLE routing_public.site_themes 
  DROP COLUMN name RESTRICT;