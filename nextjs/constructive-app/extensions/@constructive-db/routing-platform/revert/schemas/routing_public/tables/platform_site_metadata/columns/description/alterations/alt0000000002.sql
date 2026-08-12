-- Revert: schemas/routing_public/tables/platform_site_metadata/columns/description/alterations/alt0000000002


ALTER TABLE routing_public.platform_site_metadata 
  DROP CONSTRAINT platform_site_metadata_description_chk RESTRICT;