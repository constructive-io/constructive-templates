-- Revert: schemas/routing_public/tables/platform_apis/columns/anon_role/column


ALTER TABLE routing_public.platform_apis 
  DROP COLUMN anon_role RESTRICT;