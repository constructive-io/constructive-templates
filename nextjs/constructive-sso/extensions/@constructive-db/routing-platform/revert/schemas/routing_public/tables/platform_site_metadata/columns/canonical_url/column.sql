-- Revert: schemas/routing_public/tables/platform_site_metadata/columns/canonical_url/column


ALTER TABLE routing_public.platform_site_metadata 
  DROP COLUMN canonical_url RESTRICT;