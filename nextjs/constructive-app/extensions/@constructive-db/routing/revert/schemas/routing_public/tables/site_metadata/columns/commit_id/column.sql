-- Revert: schemas/routing_public/tables/site_metadata/columns/commit_id/column


ALTER TABLE routing_public.site_metadata 
  DROP COLUMN commit_id RESTRICT;