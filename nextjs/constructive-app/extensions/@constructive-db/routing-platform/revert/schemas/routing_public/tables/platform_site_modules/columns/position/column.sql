-- Revert: schemas/routing_public/tables/platform_site_modules/columns/position/column


ALTER TABLE routing_public.platform_site_modules 
  DROP COLUMN "position" RESTRICT;