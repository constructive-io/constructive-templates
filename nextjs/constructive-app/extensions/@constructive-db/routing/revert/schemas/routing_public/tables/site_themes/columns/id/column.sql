-- Revert: schemas/routing_public/tables/site_themes/columns/id/column


ALTER TABLE routing_public.site_themes 
  DROP COLUMN id RESTRICT;