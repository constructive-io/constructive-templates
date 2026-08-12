-- Revert: schemas/routing_public/tables/site_metadata/columns/og_image/column


ALTER TABLE routing_public.site_metadata 
  DROP COLUMN og_image RESTRICT;