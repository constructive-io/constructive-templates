-- Revert: schemas/routing_public/tables/platform_site_metadata/columns/updated_at/column


ALTER TABLE routing_public.platform_site_metadata 
  DROP COLUMN updated_at RESTRICT;