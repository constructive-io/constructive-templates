-- Revert: schemas/routing_public/tables/platform_sites/constraints/platform_sites_pkey/constraint


ALTER TABLE routing_public.platform_sites 
  DROP CONSTRAINT platform_sites_pkey RESTRICT;