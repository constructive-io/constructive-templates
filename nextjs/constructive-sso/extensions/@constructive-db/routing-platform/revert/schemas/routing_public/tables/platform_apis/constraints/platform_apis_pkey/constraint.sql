-- Revert: schemas/routing_public/tables/platform_apis/constraints/platform_apis_pkey/constraint


ALTER TABLE routing_public.platform_apis 
  DROP CONSTRAINT platform_apis_pkey RESTRICT;