-- Revert: schemas/routing_public/tables/platform_site_metadata/constraints/platform_site_metadata_site_id_key/constraint


ALTER TABLE routing_public.platform_site_metadata 
  DROP CONSTRAINT platform_site_metadata_site_id_key RESTRICT;