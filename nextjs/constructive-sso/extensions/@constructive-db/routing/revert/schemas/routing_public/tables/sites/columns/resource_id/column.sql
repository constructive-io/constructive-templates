-- Revert: schemas/routing_public/tables/sites/columns/resource_id/column


ALTER TABLE routing_public.sites 
  DROP COLUMN resource_id RESTRICT;