-- Revert: schemas/routing_public/tables/platform_site_metadata/columns/robots/column


ALTER TABLE routing_public.platform_site_metadata 
  DROP COLUMN robots RESTRICT;