-- Revert: schemas/routing_public/tables/site_metadata/constraints/site_metadata_site_id_fkey/constraint


ALTER TABLE routing_public.site_metadata 
  DROP CONSTRAINT site_metadata_site_id_fkey RESTRICT;