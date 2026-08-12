-- Revert: schemas/routing_public/tables/site_themes/columns/database_id/column


ALTER TABLE routing_public.site_themes 
  DROP COLUMN database_id RESTRICT;