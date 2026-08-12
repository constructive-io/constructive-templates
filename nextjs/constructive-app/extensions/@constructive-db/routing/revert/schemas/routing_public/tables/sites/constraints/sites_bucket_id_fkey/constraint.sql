-- Revert: schemas/routing_public/tables/sites/constraints/sites_bucket_id_fkey/constraint


ALTER TABLE routing_public.sites 
  DROP CONSTRAINT sites_bucket_id_fkey RESTRICT;