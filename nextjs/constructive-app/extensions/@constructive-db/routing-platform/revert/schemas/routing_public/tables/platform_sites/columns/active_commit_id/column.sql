-- Revert: schemas/routing_public/tables/platform_sites/columns/active_commit_id/column


ALTER TABLE routing_public.platform_sites 
  DROP COLUMN active_commit_id RESTRICT;