-- Revert: schemas/routing_public/tables/platform_site_modules/columns/position/alterations/alt0000000002


ALTER TABLE routing_public.platform_site_modules 
  ALTER COLUMN "position" DROP DEFAULT;