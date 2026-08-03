-- Revert: schemas/routing_public/tables/platform_site_metadata/columns/site_id/column


ALTER TABLE routing_public.platform_site_metadata 
  DROP COLUMN site_id RESTRICT;