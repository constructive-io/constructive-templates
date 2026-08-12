-- Revert: schemas/routing_public/tables/platform_site_metadata/columns/id/column


ALTER TABLE routing_public.platform_site_metadata 
  DROP COLUMN id RESTRICT;