-- Revert: schemas/routing_public/tables/site_metadata/columns/canonical_url/column


ALTER TABLE routing_public.site_metadata 
  DROP COLUMN canonical_url RESTRICT;