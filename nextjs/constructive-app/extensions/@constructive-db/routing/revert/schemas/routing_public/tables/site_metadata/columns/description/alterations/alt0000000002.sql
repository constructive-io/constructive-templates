-- Revert: schemas/routing_public/tables/site_metadata/columns/description/alterations/alt0000000002


ALTER TABLE routing_public.site_metadata 
  DROP CONSTRAINT site_metadata_description_chk RESTRICT;