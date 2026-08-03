-- Revert: schemas/routing_public/tables/site_metadata/columns/title/alterations/alt0000000002


ALTER TABLE routing_public.site_metadata 
  DROP CONSTRAINT site_metadata_title_chk RESTRICT;