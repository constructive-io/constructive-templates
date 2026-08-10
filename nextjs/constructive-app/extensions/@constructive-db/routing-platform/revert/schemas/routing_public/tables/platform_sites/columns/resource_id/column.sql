-- Revert: schemas/routing_public/tables/platform_sites/columns/resource_id/column


ALTER TABLE routing_public.platform_sites 
  DROP COLUMN resource_id RESTRICT;