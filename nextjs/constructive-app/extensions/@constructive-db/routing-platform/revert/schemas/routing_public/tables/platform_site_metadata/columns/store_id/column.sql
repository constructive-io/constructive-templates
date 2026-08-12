-- Revert: schemas/routing_public/tables/platform_site_metadata/columns/store_id/column


ALTER TABLE routing_public.platform_site_metadata 
  DROP COLUMN store_id RESTRICT;