-- Revert: schemas/routing_public/tables/platform_site_metadata/columns/favicon/column


ALTER TABLE routing_public.platform_site_metadata 
  DROP COLUMN favicon RESTRICT;