-- Revert: schemas/routing_public/tables/platform_site_metadata/columns/commit_id/column


ALTER TABLE routing_public.platform_site_metadata 
  DROP COLUMN commit_id RESTRICT;