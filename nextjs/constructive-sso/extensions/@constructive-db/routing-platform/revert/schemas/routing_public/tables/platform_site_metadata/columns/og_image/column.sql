-- Revert: schemas/routing_public/tables/platform_site_metadata/columns/og_image/column


ALTER TABLE routing_public.platform_site_metadata 
  DROP COLUMN og_image RESTRICT;