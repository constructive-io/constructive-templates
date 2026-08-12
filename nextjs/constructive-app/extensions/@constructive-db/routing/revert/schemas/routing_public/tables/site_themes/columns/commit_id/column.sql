-- Revert: schemas/routing_public/tables/site_themes/columns/commit_id/column


ALTER TABLE routing_public.site_themes 
  DROP COLUMN commit_id RESTRICT;