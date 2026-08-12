-- Revert: schemas/routing_public/tables/sites/columns/active_commit_id/column


ALTER TABLE routing_public.sites 
  DROP COLUMN active_commit_id RESTRICT;