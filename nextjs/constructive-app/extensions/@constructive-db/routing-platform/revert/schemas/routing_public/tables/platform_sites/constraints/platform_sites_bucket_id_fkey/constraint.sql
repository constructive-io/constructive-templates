-- Revert: schemas/routing_public/tables/platform_sites/constraints/platform_sites_bucket_id_fkey/constraint


ALTER TABLE routing_public.platform_sites 
  DROP CONSTRAINT platform_sites_bucket_id_fkey RESTRICT;