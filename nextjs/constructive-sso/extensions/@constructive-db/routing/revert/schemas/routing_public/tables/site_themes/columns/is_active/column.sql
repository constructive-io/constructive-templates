-- Revert: schemas/routing_public/tables/site_themes/columns/is_active/column


ALTER TABLE routing_public.site_themes 
  DROP COLUMN is_active RESTRICT;