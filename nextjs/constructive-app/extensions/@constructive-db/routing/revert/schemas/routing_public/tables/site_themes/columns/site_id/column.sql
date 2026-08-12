-- Revert: schemas/routing_public/tables/site_themes/columns/site_id/column


ALTER TABLE routing_public.site_themes 
  DROP COLUMN site_id RESTRICT;