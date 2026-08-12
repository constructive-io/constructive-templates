-- Revert: schemas/routing_public/tables/platform_site_metadata/columns/created_at/column


ALTER TABLE routing_public.platform_site_metadata 
  DROP COLUMN created_at RESTRICT;