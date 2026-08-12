-- Revert: schemas/routing_public/tables/platform_sites/columns/is_published/column


ALTER TABLE routing_public.platform_sites 
  DROP COLUMN is_published RESTRICT;