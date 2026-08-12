-- Revert: schemas/routing_public/tables/site_themes/columns/store_id/column


ALTER TABLE routing_public.site_themes 
  DROP COLUMN store_id RESTRICT;