-- Revert: schemas/routing_public/tables/platform_sites/columns/bucket_id/alterations/alt0000000002


ALTER TABLE routing_public.platform_sites 
  DROP CONSTRAINT platform_sites_bucket_id_resource_id_installation_id_chk RESTRICT;