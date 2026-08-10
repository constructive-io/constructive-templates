-- Revert: schemas/routing_public/tables/sites/columns/bucket_id/alterations/alt0000000002


ALTER TABLE routing_public.sites 
  DROP CONSTRAINT sites_bucket_id_resource_id_installation_id_chk RESTRICT;