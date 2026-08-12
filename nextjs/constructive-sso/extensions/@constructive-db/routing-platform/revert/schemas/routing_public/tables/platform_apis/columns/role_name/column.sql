-- Revert: schemas/routing_public/tables/platform_apis/columns/role_name/column


ALTER TABLE routing_public.platform_apis 
  DROP COLUMN role_name RESTRICT;