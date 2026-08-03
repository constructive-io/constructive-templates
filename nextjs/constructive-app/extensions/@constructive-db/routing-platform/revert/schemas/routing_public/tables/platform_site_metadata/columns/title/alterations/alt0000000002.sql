-- Revert: schemas/routing_public/tables/platform_site_metadata/columns/title/alterations/alt0000000002


ALTER TABLE routing_public.platform_site_metadata 
  DROP CONSTRAINT platform_site_metadata_title_chk RESTRICT;