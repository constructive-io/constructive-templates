-- Revert: schemas/routing_public/tables/platform_sites/columns/name/column


ALTER TABLE routing_public.platform_sites 
  DROP COLUMN name RESTRICT;