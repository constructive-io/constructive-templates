-- Revert: schemas/routing_public/tables/platform_apis/constraints/platform_apis_name_key/constraint


ALTER TABLE routing_public.platform_apis 
  DROP CONSTRAINT platform_apis_name_key RESTRICT;